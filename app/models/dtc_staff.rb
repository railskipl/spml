class DtcStaff < ActiveRecord::Base
	attr_accessible :sub_cluster, :user_id,:cluster_id


	 def subcluster(sub)
	 	self.sub_cluster = sub
	 end
end
