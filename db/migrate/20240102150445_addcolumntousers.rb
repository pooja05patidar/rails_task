# frozen_string_literal: true

class Addcolumntousers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :contact, :number
  end
end
