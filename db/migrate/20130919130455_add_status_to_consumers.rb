class AddStatusToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :status, :boolean
  end
end
