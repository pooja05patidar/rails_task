class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_many :restaurants, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :order #, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  enum role: {owner: 0 , customer: 1}
  def jwt_payload
    super
  end
end
