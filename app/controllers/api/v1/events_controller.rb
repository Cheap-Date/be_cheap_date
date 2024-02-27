class Api::V1::EventsController < ApplicationController
  def index
    # /api/v1/events
    # results returned hard-coded to 25
    results = YelpSearchFacade.new(params[:location], limit=25).event_search
    render json: EventSerializer.new(results)
  end
end