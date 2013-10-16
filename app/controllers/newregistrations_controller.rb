class NewregistrationsController < Devise::RegistrationsController
  # def new
  #   #super
  #   resource = build_resource({})
  #   resource.build_schedule
  #   respond_with resource
    
  # end

  # def show
  #   resource.schedule || resource.build_schedule
  #   super
  # end

  # def create
  #   # debugger
  #   # resource = build_resource(params[:user])
  #   # resource.build_schedule(params[:schedule])

  #   # if resource.save
  #   #   sign_in(resource_name, resource)
  #   #   respond_with resource, :location => after_sign_up_path_for(resource)
  #   # else
  #   #   render :action => "new"
  #   # end

  #   debugger

  #   build_resource(sign_up_params)

  #   resource.ip_address = request.remote_ip
    
  #   if resource.save_with_payment(params[:payment_detail])

  #     if resource.active_for_authentication?
  #       set_flash_message :notice, :signed_up if is_navigational_format?
  #       sign_up(resource_name, resource)
  #       respond_with resource, :location => after_sign_up_path_for(resource)
  #     else
  #       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
  #       expire_session_data_after_sign_in!
  #       respond_with resource, :location => after_inactive_sign_up_path_for(resource)
  #     end
  #   else
  #     clean_up_passwords resource
  #     respond_with resource
  #   end

  # end

  def create    
    resource = build_resource(sign_up_params)

    if params[:payment_detail]
        payment_detail = resource.build_payment_detail(params[:payment_detail])
        payment_detail.ip_address = request.remote_ip
    end
   
    if resource.valid? && resource.save_with_payment
        if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_navigational_format?
            sign_up(resource_name, resource)
            respond_with resource, :location => after_sign_up_path_for(resource)
        else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
            expire_session_data_after_sign_in!
            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
    else
        clean_up_passwords resource
        #respond_with resource   
        render :new
    end

  end 

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if update_resource(resource, account_update_params)
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  

  
end 