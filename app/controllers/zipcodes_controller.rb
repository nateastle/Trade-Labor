class ZipcodesController < ApplicationController
	def index
  @zip_code = ZipCode.where(["\"ZipCode\" like ?", "%#{params[:term]}%"])
  #ZipCode.find(params[:id])
  #@zipcodes = Zipcodes.order(:zip_code).where("zip_code like ?", "%#{params[:term]}%")
  render json: @zip_code.map(&:ZipCode )
end
end
