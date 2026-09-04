class Micropost < ApplicationRecord
  attr_accessor :remove_image 
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarking_users,
           through: :bookmarks,
           source: :user
  has_many :likes, dependent: :destroy
  belongs_to :shop, optional: true
  accepts_nested_attributes_for :shop
  belongs_to :shop
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(pinned: :desc,created_at: :desc) }#pinnedをtrue→false（1→0なので降順（desc））に並び替えてから作成時間が新しい→古い（降順）に並び替える
  scope :ranking, -> {
   unscoped
    .left_joins(:likes)
    .group(:id)
    .order('COUNT(likes.id) DESC')
  }
  validates :user_id, presence: true
  validates :shop_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }
end
