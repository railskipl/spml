class MobileDevisesController < ApplicationController
  before_action :set_mobile_devise, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate

  # GET /mobile_devises
  # GET /mobile_devises.json
  def index
    @mobile_devises = MobileDevise.all
  end

  # GET /mobile_devises/1
  # GET /mobile_devises/1.json
  def show
  end

  # GET /mobile_devises/new
  def new
    @mobile_devise = MobileDevise.new
  end

  # GET /mobile_devises/1/edit
  def edit
  end

  # POST /mobile_devises
  # POST /mobile_devises.json
  def create
    @mobile_devise = MobileDevise.new(params[:mobile_devise])

    respond_to do |format|
      if @mobile_devise.save
        format.html { redirect_to @mobile_devise, notice: 'Mobile devise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mobile_devise }
      else
        format.html { render action: 'new' }
        format.json { render json: @mobile_devise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobile_devises/1
  # PATCH/PUT /mobile_devises/1.json
  def update
    respond_to do |format|
      if @mobile_devise.update(params[:mobile_devise])
        format.html { redirect_to @mobile_devise, notice: 'Mobile devise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mobile_devise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobile_devises/1
  # DELETE /mobile_devises/1.json
  def destroy
    @mobile_devise.destroy
    respond_to do |format|
      format.html { redirect_to mobile_devises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile_devise
      @mobile_devise = MobileDevise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mobile_devise_params
      params.require(:mobile_devise).permit(:imei, :manufacturer_name, :purchase_date, :phone_no)
    end

    def authenticate
      deny_access unless signed_in?
    end 
end
