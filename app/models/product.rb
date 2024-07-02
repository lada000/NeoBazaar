class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :cart_items

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true, inclusion: { in: %w[USD] }
  validates :status, presence: true, inclusion: { in: %w[Draft Published Deactivated] }
  validates :delivery_time, presence: true, inclusion: { in: ['Instantly', '1 hour', '6 hours', '12 hours', '24 hours'] }

  has_one_attached :image
  has_one_attached :thumbnail
  has_one_attached :file
end
