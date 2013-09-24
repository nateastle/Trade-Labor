class WelcomeController < ApplicationController
  def index
  	# @users = User.text_search(params[:query])
  	@users = User.find_users(params[:query]  , current_user )
  end

   def show
    @user = User.find(params[:id])
    
  end
end
