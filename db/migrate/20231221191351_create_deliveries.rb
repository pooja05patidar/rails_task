class CreateDeliveries < ActiveRecord::Migration[7.1]
  def change
    create_table :deliveries do |t|
      t.references :order, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true
      t.string :status
      t.datetime :delivery_time

      t.timestamps
    end
  end
end
