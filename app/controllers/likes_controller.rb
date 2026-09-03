class LikesController < ApplicationController
  before_action :logged_in_user # ログインしていないユーザーがいいねできないようにする（一応）
  before_action :set_micropost

  def create
    current_user.likes.find_or_create_by!(micropost: @micropost)
    redirect_back fallback_location: root_url, status: :see_other
  end

  def destroy
    current_user.likes.find_by(micropost: @micropost)&.destroy
    redirect_back fallback_location: root_url, status: :see_other
  end

  private

    def set_micropost
      @micropost = Micropost.find(params[:micropost_id])
    end
end