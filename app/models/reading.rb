
class Reading < ActiveRecord::Base

 include Gmaps4rails::ActsAsGmappable
attr_accessible :meter_reading,:consumer_no,:meter_status,:date_time,:latitude,:longitude,:ime_no,:img,:old_meter_no,:new_meter_no,:bu,:pc,:dtc,:bill_month,:consumer_name,:reader_mobile_no,:meter_reader_status,:remark,:read_by,:pincode,:address,:city,:consumer_name,:pole_no,:status,:consumer_status,:image,:photo,:user_id

  #has_attached_file :photo
  mount_uploader :image, ImageUploader
  acts_as_gmappable :process_geocoding => false

# def picture_from_url(url)
#     self.photo = URI.parse(url)
#   end

def gmaps4rails_infowindow
   " #{self.read_by} #{self.date_time.strftime("%T %a %b %e %Y ")}"
end

def combined_value
  "#{self.bu}-#{self.pc}"
end

before_create :convert_time

def convert_time
	self.date_time = (self.created_at + (5.hour + 30.minutes))
end

def consumer_create
  Consumer.create(:consno => self.consumer_no, :bu => self.bu, :pc => self.pc,:poleno => self.pole_no,:name => self.consumer_name,:addrs => self.address,:city => self.city)	
end




end
