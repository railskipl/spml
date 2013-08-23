class Reading < ActiveRecord::Base

attr_accessible :meter_reading,:consumer_no,:meter_status,:date_time,:latitude,:longitude,:ime_no,:image,:old_meter_no,:new_meter_no,:bu,:pc,:dtc,:bill_month,:consumer_name,:reader_mobile_no,:meter_reader_status,:remark,:read_by,:pincode,:address,:city,:consumer_name,:pole_no

 mount_uploader :image, ImageUploader

end
