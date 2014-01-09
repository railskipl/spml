class DtcStaff < ActiveRecord::Base
	attr_accessible :dtc, :user_id

	# before_create :create_route_name

	# def create_route_name
	# 	self.route_name = "#{dtc}-#{bu}-#{pc}"
	# end
end
