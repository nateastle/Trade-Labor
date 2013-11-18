class UsersController < ApplicationController
	def show
		 @user = User.find(params[:id])
		 #TODO Remove this manual code from here , It is only for testing purpose.
		 @business = @user.find_or_create_business_with_current_user(current_user) if current_user && (current_user.id != @user.id)
	end

	def rate
		if current_user 
		    @business = Business.find(params[:id])
		    @business.rate(params[:stars], current_user, params[:dimension])
		    @business.update_rating_avarage
		end
		    
	    # render :update do |page|
	    #   page.replace_html @user.wrapper_dom_id(params), ratings_for(@user, params.merge(:wrap => false))
	    #   page.visual_effect :highlight, @user.wrapper_dom_id(params)
	    # end
    end
end
