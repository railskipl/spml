class ConsumersController < ApplicationController
	
  def add_csv
  end

  def import
    Consumer.import(params[:file])
    redirect_to user_root_path, notice: "CSV imported."
  end
 def consumer

   @consumer = Consumer.find_by_consno(params[:consno])

  
   
      respond_to do |format|
         format.html
         format.json { render json: {:consumer => @consumer} 
                    }

    end
end




end
