class WelcomeController < ApplicationController
  def index
  	# @users = User.text_search(params[:query])
  	@users = User.find_users(params[:query]  , current_user )
  end

   def show
    @user = User.find(params[:id])
    
  end

  def new_payment_detail
    render :partial => 'devise/registrations/payment_detail' ,:locals => {:payment_detail => PaymentDetail.new} ,  :layout => false and return 
  end
end
