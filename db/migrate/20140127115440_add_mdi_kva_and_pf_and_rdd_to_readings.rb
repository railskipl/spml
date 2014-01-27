class AddMdiKvaAndPfAndRddToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :mdi_kva, :integer
    add_column :readings, :pf, :integer
    add_column :readings, :rdd, :date
  end
end
