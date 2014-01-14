class CreateConsumerSpmls < ActiveRecord::Migration
  def change
    create_table :consumer_spmls do |t|
      t.string :computer_no
      t.string :cons_cd
      t.string :cons_no
      t.string :account_no
      t.string :category
      t.string :name
      t.string :addr1
      t.string :addr2
      t.string :pole_no
      t.string :meter_no
      t.string :meter_capacity
      t.string :connected_load
      t.string :connection_status

      t.timestamps
    end
  end
end
