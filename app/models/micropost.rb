class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(pinned: :desc,created_at: :desc) }#pinnedをtrue→false（1→0なので降順（desc））に並び替えてから作成時間が新しい→古い（降順）に並び替える
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }
end
