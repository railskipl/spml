class AddMeterReaderToMeterReaderStatuses < ActiveRecord::Migration
  def change
    add_column :meter_reader_statuses, :meter_status_id, :integer
  end
end
