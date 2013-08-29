class AddConsumerStatusToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :consumer_status, :string
  end
end
