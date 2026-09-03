class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  validates :user_id, uniqueness: { scope: :micropost_id } # ユーザーが同じ投稿に複数回いいねできないようにするため
end