class CreateMrConsumers < ActiveRecord::Migration
  def change
    create_table :mr_consumers do |t|
      t.string :computer_no
      t.string :name
      t.string :conn_add1
      t.string :conn_add2
      t.string :cons_code
      t.string :meter_no
      t.string :sub_cluster
      t.string :walking_seq_no

      t.timestamps
    end
  end
end
