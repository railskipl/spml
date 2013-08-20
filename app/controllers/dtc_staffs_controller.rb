class DtcStaffsController < ApplicationController
  before_action :set_dtc_staff, only: [:show, :edit, :update, :destroy]

  # GET /dtc_staffs
  # GET /dtc_staffs.json
  def index
    @dtc_staffs = DtcStaff.all
  end

  # GET /dtc_staffs/1
  # GET /dtc_staffs/1.json
  def show
  end

  # GET /dtc_staffs/new
  def new
    @dtc_staff = DtcStaff.new
  end

  # GET /dtc_staffs/1/edit
  def edit
    @edu_class = DtcStaff.find(params[:id])
  end

  # POST /dtc_staffs
  # POST /dtc_staffs.json
  def create

    @dtc_staff = DtcStaff.new(params[:dtc_staff])

    respond_to do |format|
      if @dtc_staff.save

        format.html { redirect_to @dtc_staff, notice: 'Dtc staff was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dtc_staff }
      else
        format.html { render action: 'new' }
        format.json { render json: @dtc_staff.errors, status: :unprocessable_entity }
      end
    end
  end
  
   def dtc
   @dtc = Consumer.find_all_by_dtc(params[:dtc])

  @dtc1 = Hash["allocated_consumer" => @dtc]
    
   
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
        format.html { redirect_to @dtc_staff, notice: 'Dtc staff was successfully updated.' }
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

   
end
