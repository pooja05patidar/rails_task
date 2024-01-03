class ChangeContactTypeToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :contact, :integer
  end
end
