class Product < ApplicationRecord
  belongs_to :user
  has_many :products 
  has_many :cart_items
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category, presence: true
end
