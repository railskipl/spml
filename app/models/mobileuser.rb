class Mobileuser < ActiveRecord::Base

attr_accessible :user_id,:imei

belongs_to :user

end
