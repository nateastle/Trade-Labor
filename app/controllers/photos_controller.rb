class PhotosController < ApplicationController
	def index
        @user = User.find(params[:user_id])
		@photos = @user.try('photos') || []
    end
    
    def show
   		 @photo = Photo.find(params[:id])
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
		@photo = Photo.find(params[:id])
		@photo.destroy
		redirect_to user_photos_url, notice: "Image was successfully destroyed."
	end
end

