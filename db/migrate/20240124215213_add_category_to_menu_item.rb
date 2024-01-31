# frozen_string_literal: true

class AddCategoryToMenuItem < ActiveRecord::Migration[7.1]
  def change
    add_column :menu_item, :category, :string
  end
end
