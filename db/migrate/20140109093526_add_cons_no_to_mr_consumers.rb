class AddConsNoToMrConsumers < ActiveRecord::Migration
  def change
    add_column :mr_consumers, :cons_no, :string
  end
end
