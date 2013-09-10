class AddImgToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :img, :binary
  end
end
