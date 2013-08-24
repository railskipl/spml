class CreateMeterStatuses < ActiveRecord::Migration
  def change
    create_table :meter_statuses do |t|
      t.string :billing_meter_status

      t.timestamps
    end
  end
end
