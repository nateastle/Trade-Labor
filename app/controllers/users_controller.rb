class UsersController < ApplicationController

  before_filter :authenticate_user! , :only => [:rate,:post_feedback]
  before_filter :find_business , :only => [:show]

	def show	
		 @rated_business_array = @user.employee_businesses.rated	|| []	
	end

	def rate
	    @business = Business.find(params[:id])
	    @business.rate(params[:stars], current_user, params[:dimension])
  end
	
	def post_feedback
		business = current_user.employer_businesses.find_by_id(params[:business_id])
		if !business.is_feedback_submitted?
			  business.update_attributes({:feedback_text => params[:business][:feedback_text] ,:feedback_submited_at => Time.now })
	  		flash[:notice] = "Feedback submitted successfully"
	  else
	  		flash[:notice] = "Feedback could not be submitted"
	  end  
	  redirect_to user_path(business.employee_id)
  end

	private 

	def find_business
		@user = User.find(params[:id])
		@business = @user.find_or_create_business_with_current_user(current_user) if current_user && (current_user.id != @user.id) 	 	
	end	

end
