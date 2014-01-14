class MeterReaderStatus < ActiveRecord::Base
	attr_accessible :description, :meter_statuses_id
	validates_presence_of :description
end
