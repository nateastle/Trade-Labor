class WelcomeController < ApplicationController
    RADIUS = 25
  def index
  	# @users = User.text_search(params[:search])
    if(current_user)
    @search = User.search do
        fulltext params[:search]
        with(:location).in_radius(current_user.zipcode.Latitude.to_f, current_user.zipcode.Longitude.to_f, RADIUS)
        paginate :page => 1, :per_page => 25
      end
  @users = @search.results
end
  end

   def show
    @user = User.find(params[:id])
    
  end

  def new_payment_detail
    render :partial => 'devise/registrations/payment_detail' ,:locals => {:payment_detail => PaymentDetail.new} ,  :layout => false and return 
  end

end
