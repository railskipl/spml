class ReadingsController < ApplicationController



  # GET /dtc_staffs
  # GET /dtc_staffs.json
  def index
    @readings = Reading.paginate(:page => params[:page], :per_page => 5, :order => 'date_time DESC')
  end

  # GET /dtc_staffs/1
  # GET /dtc_staffs/1.json
  def show
    @reading = Reading.find(params[:id])
  end

  # GET /dtc_staffs/new
  def new
    @reading = Reading.new
    unless signed_in?
      redirect_to "/"
    end
  end

  # GET /dtc_staffs/1/edit
  def edit
    @reading  = Reading.find(params[:id])
  end

  # POST /dtc_staffs
  # POST /dtc_staffs.json
  def create
  #raise params[:reading][:image].inspect
  #params[:uploaded].inspect
     @user = User.find(params[:user_id])
    #@user = current_user
      @read_by = "#{@user.first_name} #{@user.last_name}" 

    @ime_no = Mobileuser.find_by_user_id(@user.id)

   # @ime_no = Mobileuser.find_by_user_id(@user.id)
   
    @reading = Reading.create(:meter_reading=>params[:meter_reading],:consumer_no=>params[:consumer_no],:pc =>params[:pc],:pincode =>params[:pincode],:bu =>params[:bu],:address=>params[:address],:city=>params[:city],:consumer_name=> params[:consumer_name],:dtc =>params[:dtc],:pole_no =>params[:poleno],:reader_mobile_no=>params[:reader_mobile_no],:date_time=>params[:date_time],:latitude=>params[:latitude],:longitude =>params[:longitude],:ime_no=> @ime_no ,:image => params[:uploaded],
    :meter_status=>params[:meter_status],:old_meter_no=>params[:old_meter_no],:new_meter_no=>params[:new_meter_no],:bill_month=>params[:bill_month],:meter_reader_status=>params[:meter_reader_status],:remark=>params[:remark],:read_by=>@read_by,:status => params[:flag],:consumer_status=>params[:consumer_status])
    
    consumer = Consumer.find_by_consno(params[:consumer_no])
     
    consumer.update_column(:status,true)
   render :status =>200,:json => { :error => "valid" } 
  end
  
  def consumer_status
    @readings_status = Reading.find_all_by_consumer_status(params[:consumer_status])
  end

  def redis
  redis = Redis.new(:url => '192.168.1.167:6379')
   msg = { 'class' => 'Reading', 'args' => [1, 2, 3], 'retry' => true }
   redis.lpush("namespace:queue:default", JSON.dump(msg))


  end 
   
  # PATCH/PUT /dtc_staffs/1
  # PATCH/PUT /dtc_staffs/1.json
  def update
    respond_to do |format|
      if @reading.update(params[:reading])
        format.html { redirect_to @reading, notice: 'Dtc staff was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dtc_staffs/1
  # DELETE /dtc_staffs/1.json
  def destroy
    @reading.destroy
    respond_to do |format|
      format.html { redirect_to readings_url }
      format.json { head :no_content }
    end
  end
 
  
    # Use callbacks to share common setup or constraints between actions.
 private
  def authenticate
    deny_access unless signed_in?
  end  


end
