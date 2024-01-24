# frozen_string_literal: true

class Deletecolumnfromorders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :time
  end
end
