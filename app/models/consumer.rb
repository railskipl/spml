class Consumer < ActiveRecord::Base
	attr_accessible :addrs, :avgc1, :avgc2, :bu, :city, :consno, :disc_tag, :dtc, :heatcon, :mf1, :mf2, :mrc, :mt1dgt, :mt2dgt, :mtr1, :mtr1st, :mtr2, :mtr2st, :name, :oldcon, :pc, :pincode, :poleno, :rdmm1, :rdmm2, :rdng1, :rdng2, :route, :seq, :tag2, :trf, :yymm1, :yymm2

  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << column_names
  #     all.each do |product|
  #       csv << product.attributes.values_at(*column_names)
  #     end
  #   end
  # end

  # def self.import(file)
  #   spreadsheet = open_spreadsheet(file)
  #   header = spreadsheet.row(1)
  #   (2..spreadsheet.last_row).each do |i|
  #     row = Hash[[header, spreadsheet.row(i)].transpose]
      
  #     graph_data = {}
      
  #     graph_data["pc"] = row["name"][0]
  #     graph_data["bu"] = row["name"][1..4]
  #     graph_data["consno"] = row["name"][5..16]
  #     graph_data["disc_tag"]= row["name"][17]
  #     graph_data["tag2"]= row["name"][18]
  #     graph_data["yymm1"]= row["name"][19..22]
  #     graph_data["yymm2"]= row["name"][23..26]
  #     graph_data["mtr1"]= row["name"][27..36]
  #     graph_data["mt1dgt"]= row["name"][37]
  #     graph_data["mf1"]= row["name"][38..39]
  #     graph_data["avgc1"]= row["name"][40..45]
  #     graph_data["mtr1st"]= row["name"][46]
  #     graph_data["rdng1"]= row["name"][47..52]
  #     graph_data["rdmm1"]= row["name"][53..56]
  #     graph_data["mtr2"]= row["name"][57..66]
  #     graph_data["mt2dgt"]= row["name"][67]
  #     graph_data["mf2"]= row["name"][68..69]
  #     graph_data["avgc2"]= row["name"][70..75]
  #     graph_data["mtr2st"]= row["name"][76]
  #     graph_data["rdng2"]= row["name"][77..82]
  #     graph_data["rdmm2"]= row["name"][83..86]
  #     graph_data["heatcon"]= row["name"][87..94]
  #     graph_data["oldcon"]= row["name"][95..102]
  #     graph_data["poleno"]= row["name"][103..108]
  #     graph_data["mrc"]= row["name"][109..110]
  #     graph_data["route"]= row["name"][111..114]
  #     graph_data["seq"]= row["name"][115..118]
  #     graph_data["name"]= row["name"][119..154]
  #     graph_data["addrs"]= row["name"][155..206]
  #     graph_data["city"]= row["name"][207..220]
  #     graph_data["pincode"]= row["name"][221..226]
  #     graph_data["dtc"]= row["name"][227..233]
  #     graph_data["trf"]= row["name"][234..235]
      
      
  #      @reading = Consumer.new(graph_data)
  #      @reading.save
  #   end
  # end

  # def self.open_spreadsheet(file)
  #   case File.extname(file.original_filename)
  #   when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
  #   when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  #   when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  #   else raise "Unknown file type: #{file.original_filename}"
  #   end
  # end

end
