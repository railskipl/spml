class ConsumersController < ApplicationController
	
  def add_csv
  end

  def import
    Consumer.import(params[:file])
    redirect_to user_root_path, notice: "CSV imported."
  end
end
