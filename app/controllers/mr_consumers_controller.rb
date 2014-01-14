class MrConsumersController < ApplicationController
  
  def index
  end

  def add_csv
   
  end

  def import
  MrConsumer.import(params[:file])
  redirect_to :back, notice: "Consumer imported."
end

 # def consumer
 #   @consumer = Consumer.find_by_consno(params[:consno])
 #    respond_to do |format|
 #         format.html
 #         format.json { render json:  @consumer }
 #    end
 # end

end
