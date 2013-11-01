class UsersController < ApplicationController
    before_filter :authenticate, :only => [:edit, :update]
    before_filter :correct_user, :only => [:edit, :update]

    
  
  def show
    @user = User.find(params[:id])

  end
  def new
    @user = User.new
    @title="Sign up"
  end
    
  def dashboard
      @users = User.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save 
      UserRole.create(:user_id => @user.id , :role_id => @user.role_id,:name => @user.first_name)
      #sign_in @user
      redirect_to staffs_path
    else
      @title = "Sign up"
      render 'new'
    end
  end

 def dtc
   @dtc_staff = DtcStaff.find_all_by_user_id(params[:id])

   @dtc_staff1 = Hash["allocated_dtc" => @dtc_staff]
    
   render :json => @dtc_staff1 
   
end


  def edit

    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def search_all
   q = params[:q]
   @consumers    = Consumer.search(name_or_addrs_or_bu_or_pc_cont: q).result 
   @readers = Reading.search(read_by_or_bu_or_pc_cont: q).result
   @users = User.search(username_cont: q).result
   @teams = Team.search(team_name_cont: q).result
  end
   
   # def change_password

   #  @user = User.find(current_user.id)

   #  if request.post?
   #    if User.authenticate(@user.email,
   #      params[:change_password][:old_password]) == @user
   #      @user.password = params[:change_password][:new_password]
   #      @user.password_confirmation =
   #      params[:change_password][:new_password_confirmation])

   #        if @user.save
   #          flash[:notice] = 'Password successfully updated!'
   #          redirect_to change_password_path
   #        else
   #          flash[:error] = 'New password mismatch.'
   #          render :action => 'change_password'
   #        end
   #    else
   #        flash[:error] = 'Old password incorrect'
   #        render :action => 'change_password'
   #    end
   #  end

   # end
     
def import
  if params[:file].nil?
   redirect_to staffs_path, alert: "Please Import File"
 else
  users =  User.import(params[:file])
  users.each do |user|
   user.mobile_no =  user.mobile_no.to_i.to_s
   user.save!
   
   UserRole.create(:user_id => user.id , :role_id => user.role_id,:name => user.first_name)
   #redirect_to staffs_path, notice: user.errors.full_messages.to_sentence
  end
   redirect_to staffs_path, notice: "Users imported."
 end
end

def search
  #@users = User.all
   if params["name"] == "readers"
    @users = User.find_all_by_role_id(2)
   elsif params["name"] == "vendors"
    @users = User.find_all_by_role_id(1)
   else
    @users = User.where("first_name iLIKE ? OR last_name iLIKE ? OR concat(first_name,' ',last_name) iLIKE ?","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")
   end
 respond_to do |format|
      format.html
      format.xls 
 end

end



    
    
  private
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user=(@user)
  end

  #attr_accessible Replaced by Strong Parameters
     
     
end
