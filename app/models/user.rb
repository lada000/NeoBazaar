class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_many :carts
  has_many :orders

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  before_create :assign_admin_if_necessary

  def admin?
    role == 'admin'
  end

  def self.create!(username:, email:, password:)
    # code here
  end

  private

  def assign_admin_if_necessary
    self.role = 'admin' if email == ENV['ADMIN_EMAIL']
  end
end
