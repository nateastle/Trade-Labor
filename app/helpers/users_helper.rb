module UsersHelper
  def token_limit(user)

  	role_name = user.role.name

  	if user.premium_user? 
  	  	return 'null'
  	elsif user.business_user?
		   return 1
  	else
		   return 0
  	end	

  end  


  def rating_per_criteria(business) 
      rating_per_criteria_hash = {}
      Rate.where("rateable_id=? and rateable_type = ?" ,business.id,'Business').collect{|t|  rating_per_criteria_hash[t.dimension.to_sym]  = t.stars }
      rating_per_criteria_hash
  end
end
