  class ReadingsController < ApplicationController

 before_filter :authenticate ,:except => [:create]

  # GET /dtc_staffs
  # GET /dtc_staffs.json
  def index
    @readings = Reading.paginate(:page => params[:page], :per_page => 5, :order => 'created_at DESC')
    # @reads = Reading.all
    respond_to do |format|
      format.html
      format.xls
       format.pdf do
         render :pdf => "file_name"
       end
      end
  end

  def ankit
    @readings = Reading.all
    file = "my_file.txt"
     account_no = []
     @readings.each do |r|
    
     account_no << r.account_no  << "$" << r.consumer_no << "\n"
     end

     File.open(file, "w"){ |f| f << account_no.join }
    send_file( file )
  end

   def self.do_something
      count = Reading.all.count
      ReadingMailer.reading_count("ankit@kunalinfotech.net",count).deliver
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
    @user = User.find(packet[14])
    @read_by = "#{@user.first_name} #{@user.last_name}" 
    @ime_no = Mobileuser.find_by_user_id(@user.id).imei rescue nil
    location = params["location"].split("%")
    reading["latitude"]            = location[0]
    reading["longitude"]           = location[1]
    reading["cons_code"]           = packet[0]
    reading["walking_seq_no"]      = packet[1]
    reading["computer_no"]         = packet[2]
    reading["consumer_no"]         = packet[3]
    reading["consumer_name"]       = packet[4]
    reading["meter_reading"]       = packet[5]
    reading["meter_status"]        = packet[6]
    reading["old_meter_no"]        = packet[7]
    reading["bill_month"]          = packet[8]
    reading["remark"]              = packet[9]
    reading["sub_cluster"]         = packet[10]
    reading["meter_reader_status"] = packet[11]
    reading["consumer_status"]     = packet[12]
    reading["new_meter_no"]        = packet[13]
    reading["user_id"]             = packet[14]
    reading["conn_add1"]           = packet[15]
    reading["conn_add2"]           = packet[16]
    reading["cluster_id"]          = packet[17]
    reading["account_no"]          = packet[18]
    reading["read_by"]             = @read_by
    reading["ime_no"]              = @ime_no
    reading["image"]               = params["uploaded"]
    
    @reading = Reading.create(reading)
  
    if @reading.consumer_status == "true"
     consumer = MrConsumer.find_by_cons_no_and_sub_cluster(packet[3], packet[10])
     consumer.update_column(:status,true) rescue nil
     render :status =>200,:json => @reading.consumer_no.to_json
    else
     @reading.consumer_create
     render :status =>200,:json => @reading.consumer_no.to_json
    end
  end
  
  def consumer_status
    @readings_status = Reading.find_all_by_consumer_status(params[:consumer_status],:order => 'created_at DESC')
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
    consumer = MrConsumer.find_by_cons_no(@reading.consumer_no)
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
     redirect_to user_tracking_url, alert: "Please Select Date"
    else
     if start_from > start_to
       redirect_to user_tracking_url, alert: "Start Date Cannot Be Greater"
      else
      @readings = Reading.where("read_by LIKE ? and  created_at >= ? and date(created_at) <= ?" ,reader,start_from,start_to)
      end
    end
  end

  def user_map
    readings =  params["reading_ids"]
    if readings.nil?
    redirect_to :back , :alert => "Please Select Reading"
    else
      @readings ||= []
      readings.each do |reading|
       @readings <<  Reading.find_by_id(reading)
      end
      @json =  @readings.to_gmaps4rails
      render :layout => "user_map"
    end
  end

   def toggled_status
    @reading = Reading.find(params[:id])
    @reading.status = !@reading.status?
    @reading.save!
   end

 # def search_vendor_summary
 #     if params[:search].nil? || params[:search].empty?
 #      redirect_to activity_summary_report_readings_url ,:alert => "Search field cannot be empty"
 #     else
 #        user = User.where("username LIKE ?","%#{params[:search]}%")
 #      user_id = user[0].id rescue nil
 #      @user = User.find(user_id).id rescue nil
 #      @teams = Team.find_all_by_user_id(@user)
 #       respond_to do |format|
 #        format.html
 #        format.xls 
 #      end
 #    end
 #  end

   def search_by_reader
     if params[:search].nil? || params[:search].empty?
      redirect_to activity_report_readings_url ,:alert => "Search field cannot be empty"
     else
     start_from =  "#{params['start_from']}"
     start_to = "#{params['start_to']}"
     if start_from.blank? || start_to.blank?
       @readings= Reading.where("read_by LIKE ?", "%#{params[:search]}%")
     else
      @readings= Reading.where("user_id LIKE ? and created_at >= ? and Date(created_at) <= ?  ", "%#{params[:search]}%",start_from,start_to)
     end
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
        redirect_to readings_path , alert: "Please Select Date"
      elsif params["consumer_status"]
        redirect_to readings_consumer_status_path(params.merge(format: "")) , alert: "Please select date and time"
      else
        redirect_to activity_report_readings_url, alert: "Please Select Date"
      end
    else
      if start_from > start_to
        if params["reading_index"]
          redirect_to readings_path , alert: "Start Date Cannot Be Greater"
        elsif params["consumer_status"]
          redirect_to readings_consumer_status_path(params.merge(format: "")) , alert: "Start Date Cannot Be Greater"
        else
          redirect_to activity_report_readings_url, alert: "Start Date Cannot Be Greater"
        end
      else
        if params["consumer_status"]
         @readings = Reading.where("created_at >= ? and Date(created_at) <= ? and consumer_status = ? " ,start_from,start_to, params["consumer_status"])
         respond_to do |format|
          format.html
          format.xls
          format.pdf do
            render :pdf => "file_name"
          end
         end
        else
         @readings = Reading.where("created_at >= ? and Date(created_at) <= ?" ,start_from,start_to)
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

    @start_from =  "#{params['start_date']}"
    @start_to = "#{params['end_date']}"
    @reader = params['reader']
    if @start_from.blank? || @start_to.blank?
     redirect_to activity_summary_report_readings_url, alert: "Please Select Date"
    else
      if @start_from > @start_to
        redirect_to activity_summary_report_readings_url, alert: "Start Date Cannot Be Greater"
      else
         if @reader.blank?
          @readings = Reading.where("created_at >= ? and date(created_at) <= ?" ,@start_from,@start_to).uniq.pluck(:user_id)
         else
          @readings = Reading.where("read_by LIKE ? and  created_at >= ? and date(created_at) <= ?" ,"%#{@reader}%",@start_from,@start_to).uniq.pluck(:user_id)
         end
      end
    end
  end

  def readers_map

    @readings = Reading.where("concat(bu,'-',pc) LIKE ?",params[:myselecttsms1])
    @json = @readings.to_gmaps4rails
  end
  
    # Use callbacks to share common setup or constraints between actions.
 private
  def authenticate
    deny_access unless signed_in?
  end  


end
