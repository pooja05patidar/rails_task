# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
  end
end
