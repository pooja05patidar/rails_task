class Addtimetoorder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :time, :datetime
  end
end
