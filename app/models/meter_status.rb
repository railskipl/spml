class MeterStatus < ActiveRecord::Base
	attr_accessible :billing_meter_status
	validates_presence_of :billing_meter_status
	has_many :meter_reader_statuses
end
