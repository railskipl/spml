class MobileDevise < ActiveRecord::Base
	attr_accessible :imei, :manufacturer_name, :purchase_date, :phone_no
end
