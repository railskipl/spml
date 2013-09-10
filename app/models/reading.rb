
class Reading < ActiveRecord::Base

attr_accessible :meter_reading,:consumer_no,:meter_status,:date_time,:latitude,:longitude,:ime_no,:img,:old_meter_no,:new_meter_no,:bu,:pc,:dtc,:bill_month,:consumer_name,:reader_mobile_no,:meter_reader_status,:remark,:read_by,:pincode,:address,:city,:consumer_name,:pole_no,:status,:consumer_status,:image,:photo

  #has_attached_file :photo
  mount_uploader :image, ImageUploader

# def picture_from_url(url)
#     self.photo = URI.parse(url)
#   end

before_create :convert_time

def convert_time
	self.date_time = (self.created_at + (5.hour + 30.minutes))
end

end
