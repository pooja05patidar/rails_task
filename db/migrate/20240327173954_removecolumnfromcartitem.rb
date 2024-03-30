class Removecolumnfromcartitem < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :cart_id, :integer
  end
end
