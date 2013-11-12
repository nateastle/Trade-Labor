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

  
end
