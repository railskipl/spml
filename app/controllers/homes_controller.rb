class HomesController < ApplicationController
 def index
    if signed_in?
      redirect_to("/dashboard")
    else
    
    end
  end
end
