class ConsumerSpmlsController < ApplicationController
  def index
  end
   def import
  	  ConsumerSpml.import(params[:file])
  redirect_to root_url, notice: "Products imported."
  end
end
