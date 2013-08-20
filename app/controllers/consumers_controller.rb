class ConsumersController < ApplicationController
	
  def add_csv
  end

  def import
    Consumer.import(params[:file])
    redirect_to user_root_path, notice: "CSV imported."
  end
 def consumer
   @consumer = Consumer.find_by_consno(params[:consno])
   

   @consumer1 = Hash["consumer" => @consumer]
    
   
   respond_to do |format|
        format.html
        format.json { render json: @consumer1 }

    end
end




end
