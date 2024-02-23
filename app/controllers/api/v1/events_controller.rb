class Api::V1::EventsController < ApplicationController
  def index
    results = YelpSearchFacade.new(params[:location]).parsed_results
    render json: EventSerializer.new.serialize_json(results)
  end
end