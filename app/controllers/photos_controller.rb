class PhotosController < ApplicationController
	
	before_filter :find_user , :only => [:index , :show , :set_as_profile_photo]
	

	def index
		@photos = @user.try('photos').paginate(:page => params[:page], :per_page => 6) || []
		@photo = Photo.new
    end
    
    def show
		@photo = @user.try('photos').find(params[:id])
		respond_to do |format|
		 	format.html
		 	format.js
		end
	end
	
	def new
		@photo = Photo.new
    end

	def create
		@photo = current_user.photos.new(params[:photo])
		if @photo.save
			redirect_to user_photos_url, notice: "Image was successfully saved."
		else
			render :new
		end
	end

	def destroy
		@photo = current_user.photos.find(params[:id])
		if @photo.destroy
			@photo.destroy
			flash[:notice] = "Image was successfully destroyed."
		else
			flash[:alert] = "You are not allow to remove this Image."
		end	
		redirect_to user_photos_url
	end

	def set_as_profile_photo
		@photo = current_user.photos.find(params[:id])
		if @photo
		   current_user.photos.update_all(:is_profile_photo => false)
		   @photo.update_attribute(:is_profile_photo , true)
		end	
	end		

	private

	def find_user
		@user = User.find(params[:user_id])
	end	

end

