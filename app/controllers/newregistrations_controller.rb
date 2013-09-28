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
  #   resource = build_resource(params[:user])
  #   resource.build_schedule(params[:schedule])
  #   #@schedules = resource.schedules.new(params[:schedules])
  #   #@schedules.save
  #   if(resource.save)

  #     sign_in(resource_name, resource)
  #     respond_with resource, :location => after_sign_up_path_for(resource)
  #   else
  #     render :action => "new"
  #   end


  # end

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