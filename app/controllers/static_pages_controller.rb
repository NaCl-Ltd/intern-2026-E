class StaticPagesController < ApplicationController

  def home
    if logged_in?

      @micropost = current_user.microposts.build

      @feed_items = current_user.feed
                           .reorder( #micropostにorderがあるためreorderで並び替えする必要がある
                             #0 → 自分のpinned=true
                             #1 → 他のユーザー
                             #2 → 自分のpinned=false の順番となるように並び替え
                             Arel.sql( 
                               "CASE
                                  WHEN user_id = #{current_user.id} AND pinned = TRUE THEN 0
                                  WHEN user_id != #{current_user.id} THEN 1
                                  ELSE 2
                                END"
                             ), #昇順
                             created_at: :desc
                           )
                           .paginate(page: params[:page])

    end
  end

  def help
  end

  def about
  end

  def contact
  end
end