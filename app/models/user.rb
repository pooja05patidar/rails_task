class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, :address, presence: { message: "Please provide name and address" }
  validates :contact, presence: { message: "Please provide contact number" }, numericality: { only_integer: true, message: "Contact number should be a valid number" }, length: { is: 10, message: "Contact number should be 10 digits long" }
  has_many :restaurants, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :order , dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  enum role: { guest: 0, customer: 1, owner: 2, admin: 3 }
  def jwt_payload
    super
  end
end
