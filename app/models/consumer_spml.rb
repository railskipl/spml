class ConsumerSpml < ActiveRecord::Base
 attr_accessible :computer_no,:cons_cd,:cons_no,:account_no,:category,:name,:addr1,:addr2,:pole_no,:meter_no,:meter_capacity,:connected_load,:connection_status


def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(2)
  
  (3..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    #raise row.inspect
    product = find_by_id(row["id"]) || new
    product.attributes = row.to_hash.slice(*accessible_attributes)
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
