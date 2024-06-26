# frozen_string_literal: true

# user.rb
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self, omniauth_providers: %i[google_oauth2]
  after_create :send_welcome_email
  after_initialize :set_role, if: :new_record?

  paginates_per 5
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, :address, presence: true
  validates :contact, presence: { message: 'Please provide contact number' },
                      numericality: { only_integer: true, message: 'Contact number should be a valid number' },
                      length: { is: 10, message: 'Contact number should be 10 digits long' },
                      uniqueness: { scope: :id, message: 'is already taken' }
  validates :password, presence: true, length: { minimum: 6 }, format: {
    with: /\A[\w[:punct:]]+\z/,
    message: 'should include at least one special character'
  }
  validates :username, presence: true, uniqueness: true

  has_many :restaurants, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :order, dependent: :destroy
  has_many :cart_items
  has_one :cart

  enum role: { customer: 0, owner_pending_approval: 1, owner: 2, admin: 3 }

  def set_role
    self.role ||= :customer
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  private

  def send_welcome_email
    SendEmailsJob.perform_now(self)
  end
end
