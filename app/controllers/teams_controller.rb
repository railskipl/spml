class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @readers = TeamUser.find_all_by_team_id(@team.id)
  end

  def search
    if params[:search].nil? || params[:search].empty?
      redirect_to teams_url ,:alert => "Search field cannot be empty"
    else
      @teams = Team.where('team_name LIKE ?', "%#{params[:search]}%")
     respond_to do |format|
      format.html
      format.xls 
    end
    end
  end

  def search_vendor
     if params[:search].nil? || params[:search].empty?
      redirect_to teams_url ,:alert => "Search field cannot be empty"
     else
      user = User.where("username LIKE ?","%#{params[:search]}%")
      user_id = user[0].id rescue nil
      @user = User.find(user_id).id rescue nil
      @teams = Team.find_all_by_user_id(@user)
     
      respond_to do |format|
        format.html
        format.xls 
      end
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
    redirect_to teams_path
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
      a =  params["name_id"]
      b = @team["team_name"]
      c = @team["user_id"]
      if (a.nil? || b.empty? || c.nil?)
       redirect_to new_team_path, notice: 'Please Select Mandatory fields' 
      else
        respond_to do |format|
          if @team.save
             a.each do |b|
             TeamUser.create(:team_id => @team.id , :user_id => b)  
            end
            format.html { redirect_to teams_path, notice: 'Team was successfully created.' }
            format.json { render action: 'show', status: :created, location: @team }
          else
            format.html { render action: 'new' }
            format.json { render json: @team.errors, status: :unprocessable_entity }
          end
        end
      end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:team_name, :user_id)
    end


  def authenticate
    deny_access unless signed_in?
  end
  

end
