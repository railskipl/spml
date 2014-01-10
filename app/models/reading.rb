
class Reading < ActiveRecord::Base

 include Gmaps4rails::ActsAsGmappable
attr_accessible :meter_reading,:consumer_no,:meter_status,:date_time,:latitude,:longitude,
                :ime_no,:img,:old_meter_no,:new_meter_no,:bill_month,:consumer_name,
                :reader_mobile_no,:meter_reader_status,:remark,:read_by,:consumer_status,
                :image,:user_id,:walking_seq_no,:cons_code,:computer_no,:sub_cluster,
                :conn_add1,:conn_add2

  #has_attached_file :photo
  mount_uploader :image, ImageUploader
  acts_as_gmappable :process_geocoding => false
belongs_to :user
# def picture_from_url(url)
#     self.photo = URI.parse(url)
#   end

def gmaps4rails_infowindow
   " #{self.read_by} #{self.created_at.strftime("%T %a %b %e %Y ")}"
end

def combined_value
  "#{self.bu}-#{self.pc}"
end

# before_create :convert_time

# def convert_time
# 	self.date_time = (self.created_at + (5.hour + 30.minutes))
# end

def consumer_create
  MrConsumer.create(:meter_no => self.old_meter_no,:sub_cluster => self.sub_cluster,:conn_add1 => self.conn_add1,:conn_add2 => self,:cons_no => self.consumer_no,:walking_seq_no => self.walking_seq_no ,:computer_no => self.computer_no, :name => self.consumer_name,:cons_code => self.cons_code)
end




end
