class Api::V1::LocationsController < ApplicationController

  def create
    if current_user.present?
      location = current_user.locations.new(location_params)
      if location.save
        render json: { status: 'success', location_id: location.id }, status: :ok
      else
        render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'User must be logged in to create locations' }, status: :unauthorized
    end
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end
