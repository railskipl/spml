class MobileDevise < ActiveRecord::Base
	attr_accessible :imei, :manufacturer_name, :purchase_date, :phone_no
	validates_presence_of :imei,:phone_no
end
