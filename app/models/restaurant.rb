class Restaurant < ApplicationRecord
  belongs_to :user #, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :orders  #, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
