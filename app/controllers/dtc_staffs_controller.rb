class DtcStaffsController < ApplicationController
  before_action :set_dtc_staff, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate ,except: [:dtc]


  # GET /dtc_staffs
  # GET /dtc_staffs.json
  def index
    @dtc_staffs = DtcStaff.all
  end

  # GET /dtc_staffs/1
  # GET /dtc_staffs/1.json
  def show
  end

  def update_model
    @sub_cluster = MrConsumer.where(["cluster_id =? ", params[:update_model]]).uniq.pluck(:sub_cluster) 
  end
  # GET /dtc_staffs/new
  def new
    @dtc_staff = DtcStaff.new
    @cluster = MrConsumer.select("DISTINCT(cluster_id)").delete_if {|i| i.cluster_id.nil?}
    @sub_cluster = []
  end

  # GET /dtc_staffs/1/edit
  def edit
    @dtc_staff = DtcStaff.find(params[:id])
    @cluster = MrConsumer.select("DISTINCT(cluster_id)").delete_if {|i| i.cluster_id.nil?}
    @sub_cluster = MrConsumer.where(["cluster_id =? ", @dtc_staff.cluster_id]).uniq.pluck(:sub_cluster)
  end

  # POST /dtc_staffs
  # POST /dtc_staffs.json
  def create
    sub_cluster = params["dtcstaff"]["sub_cluster"]
    @dtc_staff = DtcStaff.new(params[:dtc_staff])
    @dtc_staff.subcluster(sub_cluster)
    respond_to do |format|
      if @dtc_staff.save

        format.html { redirect_to dtc_staffs_url, notice: 'Route Associated' }
        format.json { render action: 'show', status: :created, location: @dtc_staff }
      else
        format.html { render action: 'new' }
        format.json { render json: @dtc_staff.errors, status: :unprocessable_entity }
      end
    end
  end
  
   def dtc
   @dtc = MrConsumer.find_all_by_sub_cluster(params[:dtc])
   @meter ||= []
   @meter_reader_status ||= []
   MeterStatus.all.each do |meter_status|
   @meter << meter_status.billing_meter_status
   end
 
   MeterReaderStatus.all.each do |meter_reader_status|
    @meter_reader_status << meter_reader_status.description
   end 

  @dtc1 = Hash["allocated_consumer" => @dtc, "meter_status" => @meter]

   respond_to do |format|
        format.html
        format.json { render json: @dtc1 }

end
   


 end
  # PATCH/PUT /dtc_staffs/1
  # PATCH/PUT /dtc_staffs/1.json
  def update
    respond_to do |format|
      if @dtc_staff.update(params[:dtc_staff])
        format.html { redirect_to dtc_staffs_url, notice: 'Route Updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dtc_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dtc_staffs/1
  # DELETE /dtc_staffs/1.json
  def destroy
    @dtc_staff.destroy
    respond_to do |format|
      format.html { redirect_to dtc_staffs_url }
      format.json { head :no_content }
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dtc_staff
      @dtc_staff = DtcStaff.find(params[:id])
    end
    
    def authenticate
      deny_access unless signed_in?
    end 

   
end
