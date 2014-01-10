class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.float :meter_reading
      t.string :consumer_no
      t.string :meter_status
      t.datetime :date_time
      t.float :latitude
      t.float :longitude
      t.string :ime_no
      t.string :image
      t.string :old_meter_no
      t.string :new_meter_no
      t.string :bill_month
      t.string :consumer_name
      t.string :reader_mobile_no
      t.string :meter_reader_status
      t.text :remark
      t.string :read_by
      t.string :consumer_status 
      t.string :walking_seq_no
      t.integer :user_id
      t.string :cons_code
      t.string :computer_no
      t.timestamps
    end
  end
end
