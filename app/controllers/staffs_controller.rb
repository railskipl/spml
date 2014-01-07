class StaffsController < ApplicationController
  before_filter :authenticate
  def index
    @users = User.find_all_by_is_admin(false)
  end

  private
   def authenticate
      deny_access unless signed_in?
    end

end
