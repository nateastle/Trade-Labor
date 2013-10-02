class SearchSuggestionsController < ApplicationController
	def index
		#@users =  User.text_search(params[:term])  
		
		@users = User.find_users(params[:term]  , current_user )
		render json: @users
	end
end
