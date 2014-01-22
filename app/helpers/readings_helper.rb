module ReadingsHelper
 	def reader_details(r)
		Reading.find_by_user_id(r)
	end
	
	def reading_count(r)	
		Reading.where("created_at >= ? and date(created_at) <= ? and user_id = ?" ,@start_from,@start_to,r).count
	end
end
