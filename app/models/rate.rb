class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
  validates_numericality_of :stars, :minimum => 1
  
  attr_accessible :rate, :dimension

  before_create :update_rating_avarage

  def update_rating_avarage
	  # TODO , We can do this calculation by using the methods of gem ajaxfull_rating as well.
  		avg  = 0
  		global_avg = 0
  		counter = 0
  		business = self.rateable
  		emp = self.rateable.employee
		  
		  business_avg_rating = (((business.average_rating.to_f)* Business::DIMENSIONS_ARRAY.size.to_f) + self.stars.to_f)/Business::DIMENSIONS_ARRAY.size.to_f
  		business.update_attributes({ :average_rating => business_avg_rating ,:rated_at => Time.now })
  		
			emp_global_rating = ((emp.rating_average * (emp.employee_businesses.size - 1 ).to_f) + business.average_rating.to_f)/emp.employee_businesses.size.to_f
  		emp.update_attribute(:rating_average , emp_global_rating)


  		# emp_businesses = self.employee.employee_businesses
  		# business_rates = Rate.where("rateable_id = ? and rateable_type = ?",self.id,"Business") # self.class.name

  		# business_rates.each {|r| avg = avg + r.stars }
  		# self.average_rating =  avg.to_f/DIMENSIONS_ARRAY.size.to_f
      # self.rated_at =  Time.now
  		
	    #     if self.save
	    # 		emp_businesses.each {|b| 
	    # 			global_avg = global_avg + b.average_rating
	    # 			counter += 1
	    # 		}
	  		#    emp.update_attribute(:rating_average , global_avg/counter) unless emp_businesses.blank?
	    #       return true
	    #     else  
	    #       return false
	    #     end 

  end	

end
