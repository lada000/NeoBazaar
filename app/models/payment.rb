class Payment < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_one :payment
end
