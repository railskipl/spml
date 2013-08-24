class MeterStatusesController < ApplicationController
  before_action :set_meter_status, only: [:show, :edit, :update, :destroy]

  # GET /meter_statuses
  # GET /meter_statuses.json
  def index
    @meter_statuses = MeterStatus.all
  end

  # GET /meter_statuses/1
  # GET /meter_statuses/1.json
  def show
  end

  # GET /meter_statuses/new
  def new
    @meter_status = MeterStatus.new
  end

  # GET /meter_statuses/1/edit
  def edit
  end

  # POST /meter_statuses
  # POST /meter_statuses.json
  def create
    @meter_status = MeterStatus.new(meter_status_params)

    respond_to do |format|
      if @meter_status.save
        format.html { redirect_to @meter_status, notice: 'Meter status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meter_status }
      else
        format.html { render action: 'new' }
        format.json { render json: @meter_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meter_statuses/1
  # PATCH/PUT /meter_statuses/1.json
  def update
    respond_to do |format|
      if @meter_status.update(meter_status_params)
        format.html { redirect_to @meter_status, notice: 'Meter status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meter_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meter_statuses/1
  # DELETE /meter_statuses/1.json
  def destroy
    @meter_status.destroy
    respond_to do |format|
      format.html { redirect_to meter_statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meter_status
      @meter_status = MeterStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meter_status_params
      params.require(:meter_status).permit(:billing_meter_status)
    end
end
