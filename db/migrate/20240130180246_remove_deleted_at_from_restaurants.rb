# frozen_string_literal: true

class RemoveDeletedAtFromRestaurants < ActiveRecord::Migration[7.1]
  def change
    remove_column :restaurants, :deleted_at
  end
end
