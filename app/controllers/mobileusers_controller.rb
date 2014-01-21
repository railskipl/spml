class MobileusersController < ApplicationController
  before_filter :authenticate
 def index
    @mobileusers = Mobileuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mobileusers }
    end
  end

  # GET /banks/1
  # GET /banks/1.xml
  def show
    @mobileuser = Mobileuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mobileuser }
    end
  end

  # GET /banks/new
  # GET /banks/new.xml
  def new
    @mobileuser = Mobileuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mobileuser }
    end
  end

  # GET /banks/1/edit
  def edit
    @mobileuser = Mobileuser.find(params[:id])
  end

  # POST /banks
  # POST /banks.xml
  def create
    @mobileuser = Mobileuser.new(params[:mobileuser])

    respond_to do |format|
      if @mobileuser.save
        format.html { redirect_to(mobileusers_url, :notice => 'Mobile Assigned') }
        format.xml  { render :xml => @mobileuser, :status => :created, :location => @mobileuser }
      else
        format.html { render :action => "new" ,:notice => 'IMEI no already assign'}
        format.xml  { render :xml => @mobileuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /banks/1
  # PUT /banks/1.xml
  def update
    @mobileuser = Mobileuser.find(params[:id])

    respond_to do |format|
      if @mobileuser.update_attributes(params[:mobileuser])
        format.html { redirect_to(mobileusers_url, :notice => 'mobileuser was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mobileuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.xml
  def destroy
    @mobileuser = Mobileuser.find(params[:id])
    @mobileuser.destroy

    respond_to do |format|
      format.html { redirect_to(mobileusers_url) }
      format.xml  { head :ok }
    end
  end

  private
   
   def authenticate
      deny_access unless signed_in?
   end

 



end
