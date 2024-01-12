class Restaurant < ApplicationRecord
  belongs_to :user #, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :orders#, dependent: :destroy
  has_many :reviews, dependent: :destroy
  def self.ransackable_attributes(_auth_object = nil)
    %w[name id]
  end
  # validates :
end
