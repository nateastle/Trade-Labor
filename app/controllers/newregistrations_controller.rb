class NewregistrationsController < Devise::RegistrationsController
  def new
    #super
    resource = build_resource({})
    resource.build_schedule
    respond_with resource
    
  end

  def show
    resource.schedule || resource.build_schedule
    super
  end

  def create
    
    resource = build_resource(params[:user])
    resource.build_schedule(params[:schedule])
    #@schedules = resource.schedules.new(params[:schedules])
    #@schedules.save
    if(resource.save)

      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      render :action => "new"
    end


  end

  def update
    

    resource.schedule || resource.build_schedule
    resource.build_schedule(params[:schedule])
    resource.save
    #if(resource.schedule != nil)
    #  @schedules = resource.schedules.build_resource(params[:schedules])
    #  @schedules.save
      super
    #else
    #  super
    #end

  end
end 