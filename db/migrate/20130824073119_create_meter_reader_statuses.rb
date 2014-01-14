class CreateMeterReaderStatuses < ActiveRecord::Migration
  def change
    create_table :meter_reader_statuses do |t|
      t.string :description

      t.timestamps
    end
  end
end
