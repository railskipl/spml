class UserRole < ActiveRecord::Base
	attr_accessible :user_id, :role_id,:name
end
