class AddStatusToMrConsumers < ActiveRecord::Migration
  def change
    add_column :mr_consumers, :status, :boolean, :default => false
  end
end
