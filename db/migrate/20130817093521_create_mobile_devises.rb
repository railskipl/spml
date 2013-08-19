class CreateMobileDevises < ActiveRecord::Migration
  def change
    create_table :mobile_devises do |t|
      t.string :imei
      t.string :manufacturer_name
      t.date :purchase_date
      t.string :phone_no

      t.timestamps
    end
  end
end
