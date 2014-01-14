class ConsumersController < ApplicationController
	 before_filter :authenticate
   before_filter :correct_user

  def add_csv
   @search = Consumer.search(params[:q])
  end

  def route
    @search = Consumer.search(params[:q])
  end
  
  def route_list
     @consumers = Consumer.where("concat(dtc,'-',bu,'-',pc) iLIKE ?","%#{params[:search]}%")
     @dtc =  @consumers.uniq.pluck(:dtc)
     # @bu =  @consumers.uniq.pluck(:bu)
     # @pc =  @consumers.uniq.pluck(:pc)
  end

  def index
    @search = Consumer.search(params[:q])
    @consumers = @search.result
    respond_to do |format|
     format.html
     format.xls
    end
  end

  def import
    upload  = params[:file]
    unless upload.nil?
        data = upload.read
        data.split("\n").each do |b|
        graph_data = {}
      
      graph_data["pc"] = b[0]
      graph_data["bu"] = b[1..4]
      graph_data["consno"] = b[5..16]
      graph_data["disc_tag"]= b[17]
      graph_data["tag2"]= b[18]
      graph_data["yymm1"]= b[19..22]
      graph_data["yymm2"]= b[23..26]
      graph_data["mtr1"]= b[27..36]
      graph_data["mt1dgt"]= b[37]
      graph_data["mf1"]= b[38..39]
      graph_data["avgc1"]= b[40..45]
      graph_data["mtr1st"]= b[46]
      graph_data["rdng1"]= b[47..52]
      graph_data["rdmm1"]= b[53..56]
      graph_data["mtr2"]= b[57..66]
      graph_data["mt2dgt"]= b[67]
      graph_data["mf2"]= b[68..69]
      graph_data["avgc2"]= b[70..75]
      graph_data["mtr2st"]= b[76]
      graph_data["rdng2"]= b[77..82]
      graph_data["rdmm2"]= b[83..86]
      graph_data["heatcon"]= b[87..94]
      graph_data["oldcon"]= b[95..102]
      graph_data["poleno"]= b[103..108]
      graph_data["mrc"]= b[109..110]
      graph_data["route"]= b[111..114]
      graph_data["seq"]= b[115..118]
      graph_data["name"]= b[119..154]
      graph_data["addrs"]= b[155..206]
      graph_data["city"]= b[207..220]
      graph_data["pincode"]= b[221..226]
      graph_data["dtc"]= b[227..233]
      graph_data["trf"]= b[234..235]
       
      
       @reading = Consumer.new(graph_data)
       
       @reading.save
        end

    redirect_to user_root_path, notice: "CSV imported."
  else
    redirect_to add_csv_consumers_path, notice: "Please select file."
  end
end
 def consumer

   @consumer = Consumer.find_by_consno(params[:consno])
 
      respond_to do |format|
         format.html
         format.json { render json:  @consumer }

    end
end

    
  private
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    redirect_to(user_root_path) unless current_user.is_admin?
  end


end
