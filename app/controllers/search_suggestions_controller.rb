class SearchSuggestionsController < ApplicationController
	def index
		@users =  User.text_search(params[:term])  
		render json: @users.map(&:name)
	end
end
