class AddDetailsToDtcStaffs < ActiveRecord::Migration
  def change
    add_column :dtc_staffs, :bu, :string
    add_column :dtc_staffs, :pc, :string
    add_column :dtc_staffs, :route_name, :string
  end
end
