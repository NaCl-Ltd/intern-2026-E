class Shop < ApplicationRecord
  has_many :microposts, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
  validates :genre, presence: true
end
