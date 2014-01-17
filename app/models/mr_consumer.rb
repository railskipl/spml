class MrConsumer < ActiveRecord::Base
	attr_accessible :computer_no,:name,:conn_add1,:conn_add2,:cons_code,:meter_no,
					:sub_cluster,:walking_seq_no,:cons_no,:cluster_id,:account_no

 def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  header =  header.map {|i| i = i.underscore}
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    product = find_by_id(row["id"]) || new
    product.attributes = row.to_hash.slice(*accessible_attributes)
    product.account_no = product.account_no.to_i.to_s if product.account_no.class == Float
    product.account_no = product.account_no.to_s
    product.cluster_id = product.cluster_id.to_i.to_s if product.cluster_id.class == Float
    product.cluster_id = product.cluster_id.to_s
    product.computer_no = product.computer_no.to_i.to_s if product.computer_no.class == Float
    product.computer_no = product.computer_no.to_s
    product.walking_seq_no = product.walking_seq_no.to_i.to_s if product.walking_seq_no.class == Float
    product.walking_seq_no = product.walking_seq_no.to_s
    product.save!
  end
end



def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
  when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end
end
