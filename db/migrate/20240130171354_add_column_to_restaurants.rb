# frozen_string_literal: true

class AddColumnToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :is_active, :boolean
  end
end
