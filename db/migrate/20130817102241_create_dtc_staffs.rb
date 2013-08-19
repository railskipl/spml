class CreateDtcStaffs < ActiveRecord::Migration
  def change
    create_table :dtc_staffs do |t|
      t.integer :dtc
      t.integer :user_id

      t.timestamps
    end
  end
end
