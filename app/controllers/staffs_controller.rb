class StaffsController < ApplicationController
  
  def index
    @users = User.find_all_by_is_admin(false)
  end

end
