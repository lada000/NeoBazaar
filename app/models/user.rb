class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :reset_password_token, length: { is: 8 }, allow_nil: true

  before_create :set_jti

  has_many :products
  has_many :carts
  has_many :orders

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  before_create :assign_admin_if_necessary

  def admin?
    role == 'admin'
  end

  # def self.create!(username:, email:, password:)
  #   # code here
  # end

  private

  def set_jti
    self.jti ||= SecureRandom.uuid
  end

  def assign_admin_if_necessary
    self.role = 'admin' if email == ENV['ADMIN_EMAIL']
  end
end
