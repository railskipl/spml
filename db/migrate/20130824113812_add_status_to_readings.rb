class AddStatusToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :status, :boolean, :default => 0
  end
end
