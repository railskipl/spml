class Team < ActiveRecord::Base
	attr_accessible :team_name,:user_role_id,:user_id
	belongs_to :user
	has_many :team_user ,:dependent => :destroy
end
