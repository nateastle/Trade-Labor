class WelcomeController < ApplicationController
  def index
  	 @users = User.text_search(params[:query])
  end

   def show
    @user = User.find(params[:id])
    
  end
end
