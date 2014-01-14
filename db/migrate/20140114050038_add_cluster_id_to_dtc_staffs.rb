class AddClusterIdToDtcStaffs < ActiveRecord::Migration
  def change
    add_column :dtc_staffs, :cluster_id, :string
  end
end
