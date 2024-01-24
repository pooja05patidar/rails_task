# frozen_string_literal: true

class UpdateUserRole < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :role, :integer, default: 0
  end
end
