class Business < ActiveRecord::Base
   attr_accessible :employee_id, :employer_id , :title

  belongs_to :employee , :class_name => "User"
  belongs_to :employer, :class_name => "User"

  DIMENSIONS_ARRAY = [:experience, :professionalism, :timeliness ,:price , :workquality]

  ajaxful_rateable :stars => 5, :dimensions => DIMENSIONS_ARRAY

  def average_rating_for_employee
  	  return average_rating
  end	


  # TODO , We can do this calculation by using the methods of gem ajaxfull_rating as well.
  def update_rating_avarage
  		
  		# TODO , We can do this calculation by using the methods of gem ajaxfull_rating as well.
  		avg  = 0
  		global_avg = 0
  		counter = 0
  		emp = self.employee
  		emp_businesses = self.employee.employee_businesses
  		business_rates = Rate.where("rateable_id = ? and rateable_type = ?",self.id,"Business") # self.class.name

  		business_rates.each {|r| avg = avg + r.stars }
  		self.average_rating =  avg/DIMENSIONS_ARRAY.size
  		self.save

  		emp_businesses.each {|b| 
  			global_avg = global_avg + b.average_rating
  			counter += 1
  		}


  		emp.update_attribute(:rating_average , global_avg/counter) unless emp_businesses.blank?
  end	

end
