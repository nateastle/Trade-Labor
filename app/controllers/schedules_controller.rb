class SchedulesController < ApplicationController
  def new
  	@schedules = Schedule.new
  end

  def create
		@schedules = current_user.schedules.new(params[:schedule])
		if @schedules.save
			#redirect_to user_photos_url, notice: "Image was successfully saved."
		else
			render :new
		end
	end

	def update

	end
	def index
		@schedules = current_user.schedules
    end
    
    def show
   		 @schedules = Schedule.find(params[:id])
	end
end
