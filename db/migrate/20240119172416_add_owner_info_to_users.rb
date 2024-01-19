class AddOwnerInfoToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :aadhaar_card_number, :string
    add_column :users, :id_proof, :string
    add_column :users, :age, :integer
  end
end
