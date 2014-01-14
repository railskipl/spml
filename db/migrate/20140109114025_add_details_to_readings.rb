class AddDetailsToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :conn_add1, :string
    add_column :readings, :conn_add2, :string
  end
end
