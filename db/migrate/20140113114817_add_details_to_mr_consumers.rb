class AddDetailsToMrConsumers < ActiveRecord::Migration
  def change
    add_column :mr_consumers, :account_no, :string
    add_column :mr_consumers, :cluster_id, :string
  end
end
