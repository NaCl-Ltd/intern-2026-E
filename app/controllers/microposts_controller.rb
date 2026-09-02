class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :pin, :destroy]
  before_action :correct_user,   only: [:pin, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_content
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  #pin機能実装のために追加
  def pin
    @micropost = current_user.microposts.find_by(id: params[:id])

    if @micropost.present?

    if @micropost.pinned
      # すでにピンされている場合 → ピンを外す
      @micropost.update(pinned: false)

    else
      # ピンされていない場合 → 他のピンを外してからピンする
      current_user.microposts
                  .where.not(id: @micropost.id)
                  .update_all(pinned: false)

      @micropost.update(pinned: true)
    end

  end

  redirect_to request.referrer || root_url, status: :see_other
end

  private

    def micropost_params
    Rails.logger.debug "[DEBUG] --------------------------"
    Rails.logger.debug "[DEBUG] params: #{params}"
      params.require(:micropost).permit(:content, :image, :pinned) #パラムにピンを追加
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end
end
