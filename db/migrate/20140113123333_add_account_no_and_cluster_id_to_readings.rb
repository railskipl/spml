class AddAccountNoAndClusterIdToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :account_no, :string
    add_column :readings, :cluster_id, :string
  end
end
