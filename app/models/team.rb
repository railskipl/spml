class Team < ActiveRecord::Base
	attr_accessible :team_name,:user_role_id
	belongs_to :user_role
end
