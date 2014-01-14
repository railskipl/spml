class MeterReaderStatusesController < ApplicationController
  before_action :set_meter_reader_status, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate 

   


  # GET /meter_reader_statuses
  # GET /meter_reader_statuses.json
  def index
    @meter_reader_statuses = MeterReaderStatus.all
  end

  # GET /meter_reader_statuses/1
  # GET /meter_reader_statuses/1.json
  def show
  end

  # GET /meter_reader_statuses/new
  def new
    @meter_reader_status = MeterReaderStatus.new
  end

  # GET /meter_reader_statuses/1/edit
  def edit
  end

  # POST /meter_reader_statuses
  # POST /meter_reader_statuses.json
  def create
    @meter_reader_status = MeterReaderStatus.new(meter_reader_status_params)

    respond_to do |format|
      if @meter_reader_status.save
        format.html { redirect_to @meter_reader_status, notice: 'Meter reader status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meter_reader_status }
      else
        format.html { render action: 'new' }
        format.json { render json: @meter_reader_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meter_reader_statuses/1
  # PATCH/PUT /meter_reader_statuses/1.json
  def update
    respond_to do |format|
      if @meter_reader_status.update(meter_reader_status_params)
        format.html { redirect_to @meter_reader_status, notice: 'Meter reader status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meter_reader_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meter_reader_statuses/1
  # DELETE /meter_reader_statuses/1.json
  def destroy
    @meter_reader_status.destroy
    respond_to do |format|
      format.html { redirect_to meter_reader_statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meter_reader_status
      @meter_reader_status = MeterReaderStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meter_reader_status_params
      params.require(:meter_reader_status).permit(:description,:meter_statuses_id)
    end

     
  def authenticate
    deny_access unless signed_in?
  end
end
