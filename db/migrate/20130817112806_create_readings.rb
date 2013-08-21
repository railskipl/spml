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
      t.string :bu
      t.string :pc
      t.string :dtc
      t.date :bill_month
      t.string :pole_no
      t.string :consumer_name
      t.string :reader_mobile_no
      t.string :meter_reader_status
      t.text :remark
      t.integer :read_by
      t.integer :pincode
      t.string  :address
      t.string  :city
      t.string  :consumer_name
      t.timestamps
    end
  end
end
