class AddMenuItemIdToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :menu_item_id, :integer
  end
end
