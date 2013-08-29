class AddStatusToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :status, :boolean, :default => false
  end
end
