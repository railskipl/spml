class Mobileuser < ActiveRecord::Base

attr_accessible :user_id,:imei

belongs_to :user

validates_uniqueness_of :imei,:user_id

end
