class MobileDevise < ActiveRecord::Base
	attr_accessible :imei, :manufacturer_name, :purchase_date, :phone_no
	validates_presence_of :imei,:phone_no
	validates_length_of :phone_no, in:7..32
	validates_numericality_of :imei,:phone_no
end
