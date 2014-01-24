class AddNewDetailsToMrConsumers < ActiveRecord::Migration
  def change
    add_column :mr_consumers, :tariff_category, :integer
    add_column :mr_consumers, :walking_seq_sr_no, :integer
  end
end
