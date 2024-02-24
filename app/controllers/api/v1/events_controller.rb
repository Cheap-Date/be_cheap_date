class Api::V1::EventsController < ApplicationController
  def index
    results = YelpSearchFacade.new(event_params).parsed_results
    render json: EventSerializer.new.serialize_json(results)
  end

  private

  def event_params
    params.permit(:location, :price, :limit)
  end
end