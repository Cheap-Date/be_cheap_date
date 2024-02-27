class Api::V1::LocationsController < ApplicationController

  def create
    @loc = Location.new(location_params)
    @latitude = params[:location][:latitude]
    @longitude = params[:location][:longitude]
    require 'pry'; binding.pry
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end
