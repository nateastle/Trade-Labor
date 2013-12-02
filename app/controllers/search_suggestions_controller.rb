class SearchSuggestionsController < ApplicationController
	def index
		#@users =  User.text_search(params[:term])  
		logger.error "SearchSuggestionsController"
		@users = User.find_users(params[:term]  , current_user )
		@users.inspect
		render json: @users.map(&:name)

		#render json: @users
	end
end
