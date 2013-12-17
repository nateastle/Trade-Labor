class UsersController < ApplicationController

  before_filter :authenticate_user! , :only => [:rate,:post_feedback]

	def show
		 @user = User.find(params[:id])
		 #TODO Remove this manual code from here , It is only for testing purpose.
		 # if current_user && (current_user.id != @user.id)
		 # 	@business =  @user.find_or_create_business_with_current_user(current_user) 
		 # else
		 # 	@business = @user.employee_businesses.try(:first)		 	
		 # end
		 @business =  @user.find_or_create_business_with_current_user(current_user) if current_user && (current_user.id != @user.id) 	 	
		 @rated_business_array = @user.employee_businesses.rated		
	end

	def rate
		    @business = Business.find(params[:id])
		    @business.rate(params[:stars], current_user, params[:dimension])
		    if @business.update_rating_avarage
		    	@success = true
		   	else
		   		@success = false
		   	end 	
		    
	    # render :update do |page|
	    #   page.replace_html @user.wrapper_dom_id(params), ratings_for(@user, params.merge(:wrap => false))
	    #   page.visual_effect :highlight, @user.wrapper_dom_id(params)
	    # end
  end
	
	def post_feedback

			business = current_user.employer_businesses.find_by_id(params[:business_id])
			if !business.is_feedback_submitted?
				  business.update_attribute(:feedback_text ,params[:business][:feedback_text])
  		    flash[:notice] = "Feedback submitted successfully"
  		else
  			 flash[:notice] = "Feedback could not be submitted"
  		end  

  		redirect_to user_path(business.employee_id)
  end

end
