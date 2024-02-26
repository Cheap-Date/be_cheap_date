class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    location = current_user.locations.new(location_params)
    if location.save
      render json: { status: 'success', location_id: location.id }, status: :ok
    else
      render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end
