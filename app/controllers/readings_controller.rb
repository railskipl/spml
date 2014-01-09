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
   reading = {}
    packet = params["Packet1"].split("%")
    @user = User.find(packet[16])
    @read_by = "#{@user.first_name} #{@user.last_name}" 
    @ime_no = Mobileuser.find_by_user_id(@user.id).imei
    location = params["location"].split("%")
    reading["latitude"]            = location[0]
    reading["longitude"]           = location[1]
    reading["pincode"]             = packet[0]
    reading["pc"]                  = packet[1]
    reading["pole_no"]             = packet[2]
    reading["bu"]                  = packet[3]
    reading["consumer_no"]         = packet[4]
    reading["consumer_name"]       = packet[5]
    reading["meter_reading"]       = packet[6]
    reading["meter_status"]        = packet[7]
    reading["old_meter_no"]        = packet[8]
    reading["bill_month"]          = packet[9]
    reading["remark"]              = packet[10]
    reading["dtc"]                 = packet[11]
    reading["meter_reader_status"] = packet[12]
    reading["sl_no"]               = packet[13]
    reading["consumer_status"]     = packet[14]
    reading["new_meter_no"]        = packet[15]
    reading["user_id"]             = packet[16]
    reading["read_by"]             = @read_by
    reading["ime_no"]              = @ime_no
    reading["image"]               = params["uploaded"]
    
    @reading = Reading.create(reading)
  
    if @reading.consumer_status == "true"
     consumer = Consumer.find_by_consno(packet[4])
     consumer.update_column(:status,true) rescue nil
     render :status =>200,:json => @reading.consumer_no.to_json
    else
     @reading.consumer_create
     render :status =>200,:json => @reading.consumer_no.to_json
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
    @reading = Reading.find(params[:id])   
    consumer = Consumer.find_by_consno(@reading.consumer_no)
    consumer.update_column(:status,false) rescue nil
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
    start_from =  "#{params['start_date']}"
    start_to = "#{params['end_date']}"

    if start_from.blank? || start_to.blank?
     redirect_to user_tracking_url, alert: "Please select date and time"
    else
     if start_from > start_to
       redirect_to user_tracking_url, alert: "Start time cannot be greater"
      else
      @readings = Reading.where("read_by iLIKE ? and  date_time >= ? and date(date_time) <= ?" ,reader,start_from,start_to)
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
    render :layout => "user_map"
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
     @readings= Reading.where("read_by LIKE ? ", "%#{params[:search]}%")
      respond_to do |format|
        format.html
        format.xls 
        format.pdf do
            render :pdf => "file_name"
        end
      end
    end
  end


  def search_by_date
    start_from =  "#{params['start_date']}"
    start_to = "#{params['end_date']}"

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
         @readings = Reading.where("date_time >= ? and Date(date_time) <= ? and consumer_status = ? " ,start_from,start_to, params["consumer_status"])
         respond_to do |format|
          format.html
          format.xls
          format.pdf do
            render :pdf => "file_name"
          end
         end
        else
         @readings = Reading.where("date_time >= ? and Date(date_time) <= ?" ,start_from,start_to)
         respond_to do |format|
          format.html
          format.xls
          format.pdf do
            render :pdf => "file_name"
          end
         end
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
