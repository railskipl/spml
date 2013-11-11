class ReadingsController < ApplicationController

 before_filter :authenticate ,:except => [:create]

  # GET /dtc_staffs
  # GET /dtc_staffs.json
  def index
    @readings = Reading.paginate(:page => params[:page], :per_page => 5, :order => 'date_time DESC')
    respond_to do |format|
      format.html
      format.xls
       format.pdf do
         render :pdf => "file_name"
       end
      end
  end

  # GET /dtc_staffs/1
  # GET /dtc_staffs/1.json
  def show
    @reading = Reading.find(params[:id])
      @json =  @reading.to_gmaps4rails
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
  
    @reading = Reading.create(:user_id => params[:user_id] ,:meter_reading=>params[:meter_reading],:consumer_no=>params[:consumer_no],:pc =>params[:pc],:pincode =>params[:pincode],:bu =>params[:bu],:address=>params[:address],:city=>params[:city],:consumer_name=> params[:consumer_name],:dtc =>params[:dtc],:pole_no =>params[:poleno],:reader_mobile_no=>params[:reader_mobile_no],:date_time=>params[:date_time],:latitude=>params[:latitude],:longitude =>params[:longitude],:ime_no=> @ime_no ,:image => params[:uploaded],
    :meter_status=>params[:meter_status],:old_meter_no=>params[:old_meter_no],:new_meter_no=>params[:new_meter_no],:bill_month=>params[:bill_month],:meter_reader_status=>params[:meter_reader_status],:remark=>params[:remark],:read_by=>@read_by,:status => params[:flag],:consumer_status=>params[:consumer_status])

    if @reading.consumer_status == "true"
     consumer = Consumer.find_by_consno(params[:consumer_no])
     consumer.update_column(:status,true) rescue nil
     render :status =>200,:json => { :error => "valid" }

    else
     @reading.consumer_create
     render :status =>200,:json => { :error => "valid" }

    end
  end
  
  def consumer_status
    @readings_status = Reading.find_all_by_consumer_status(params[:consumer_status],:order => 'date_time DESC')
    respond_to do |format|
      format.html
      format.xls
      format.pdf do
         render :pdf => "file_name"
      end
    end
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

  def user_tracking
    @consumer = Reading.select(:bu,:pc).distinct
    # @consumer_r = Reading.select(:bu,:pc).distinct
    # raise @consumer_r.inspect
  end

  def user_tracking_report
    reader = "%#{params['reader']}%"
    start_from =  "#{params['start_date']} #{params['timepicker1']}"
    start_to = "#{params['end_date']} #{params['timepicker2']}"

    if start_from.blank? || start_to.blank?
     redirect_to user_tracking_url, alert: "Please select date and time"
    else
     if start_from > start_to
       redirect_to user_tracking_url, alert: "Start time cannot be greater"
      else
      @readings = Reading.where("read_by iLIKE ? and  date_time >= ? and date_time <= ?" ,reader,start_from,start_to)
      end
    end
  end

  def user_map
    readings =  params["reading_ids"]
    @readings ||= []
    readings.each do |reading|
     @readings <<  Reading.find_by_id(reading)
    end
    @json =  @readings.to_gmaps4rails
  end

    def search_vendor_report
     if params[:search].nil? || params[:search].empty?
      redirect_to activity_report_readings_url ,:alert => "Search field cannot be empty"
     else
        user = User.where("username iLIKE ?","%#{params[:search]}%")
      user_id = user[0].id rescue nil
      @user = User.find(user_id).id rescue nil
      @teams = Team.find_all_by_user_id(@user)

      respond_to do |format|
        format.html
        format.xls 
      end
    end
  end

 def search_vendor_summary
     if params[:search].nil? || params[:search].empty?
      redirect_to activity_summary_report_readings_url ,:alert => "Search field cannot be empty"
     else
        user = User.where("username iLIKE ?","%#{params[:search]}%")
      user_id = user[0].id rescue nil
      @user = User.find(user_id).id rescue nil
      @teams = Team.find_all_by_user_id(@user)
       respond_to do |format|
        format.html
        format.xls 
      end
    end
  end

   def search_by_reader
     if params[:search].nil? || params[:search].empty?
      redirect_to activity_report_readings_url ,:alert => "Search field cannot be empty"
     else
     @readings= Reading.where("read_by iLIKE ? ", "%#{params[:search]}%")
      respond_to do |format|
        format.html
        format.xls 
      end
    end
  end


  def search_by_date
    start_from =  "#{params['start_date']} #{params['timepicker1']}"
    start_to = "#{params['end_date']} #{params['timepicker2']}"

    if start_from.blank? || start_to.blank?
      if  params["reading_index"]
        redirect_to readings_path , alert: "Please select date and time"
      elsif params["consumer_status"]
        redirect_to readings_consumer_status_path(params.merge(format: "")) , alert: "Please select date and time"
      else
        redirect_to activity_report_readings_url, alert: "Please select date and time"
      end
    else
      if start_from > start_to
        if params["reading_index"]
          redirect_to readings_path , alert: "Start time cannot be greater"
        elsif params["consumer_status"]
          redirect_to readings_consumer_status_path(params.merge(format: "")) , alert: "Start time cannot be greater"
        else
          redirect_to activity_report_readings_url, alert: "Start time cannot be greater"
        end
      else
        if params["consumer_status"]
         @readings = Reading.where("date_time >= ? and date_time <= ? and consumer_status = ? " ,start_from,start_to, params["consumer_status"])

        else
         @readings = Reading.where("date_time >= ? and date_time <= ?" ,start_from,start_to)
        end
      end
    end
  end


  def search_by_date_summary
    start_from =  "#{params['start_date']} #{params['timepicker1']}"
    start_to = "#{params['end_date']} #{params['timepicker2']}"

    if start_from.blank? || start_to.blank?
     redirect_to activity_summary_report_readings_url, alert: "Please select date and time"
    else
    if start_from > start_to
     redirect_to activity_summary_report_readings_url, alert: "Start time cannot be greater"
    else
    @readings = Reading.where("date_time >= ? and date_time <= ?" ,start_from,start_to)
    end
    end
  end

  def readers_map

    @readings = Reading.where("concat(bu,'-',pc) iLIKE ?",params[:myselecttsms1])
    @json = @readings.to_gmaps4rails
  end
  
    # Use callbacks to share common setup or constraints between actions.
 private
  def authenticate
    deny_access unless signed_in?
  end  


end
