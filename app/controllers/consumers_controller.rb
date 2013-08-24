class ConsumersController < ApplicationController
	
  def add_csv
  end

  def import
    Consumer.import(params[:file])
    redirect_to user_root_path, notice: "CSV imported."
  end
 def consumer

   @consumer = Consumer.find_by_consno(params[:consno])

      @meter_statuses = MeterStatus.find(:all)
      @meter_reader_statuses = MeterReaderStatus.all
      @ms = []
      @mrs = []
      @meter_statuses.each do |m|
        @ms << m.billing_meter_status
      end
      @status = Hash[(0...@ms.size).zip @ms]

      @meter_reader_statuses.each do |m|
        @mrs << m.description
      end
      @reader_status = Hash[(0...@mrs.size).zip @mrs]
   
      respond_to do |format|
         format.html
         format.json { render json: {:consumer => @consumer, :status => @ms,
                                    :reader_status => @reader_status} 
                    }

    end
end




end
