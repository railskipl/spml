class TeamUser < ActiveRecord::Base
	attr_accessible :team_id, :user_role_id
	belongs_to :team
	belongs_to :user_role
end
