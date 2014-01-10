class CreateDtcStaffs < ActiveRecord::Migration
  def change
    create_table :dtc_staffs do |t|
      t.string :sub_cluster
      t.integer :user_id

      t.timestamps
    end
  end
end
