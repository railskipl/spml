class AddSubClusterToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :sub_cluster, :string
  end
end
