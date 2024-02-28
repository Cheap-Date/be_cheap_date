class Api::V1::EventsController < ApplicationController
  def index
    # /api/v1/events
    if params[:latitude] && params[:longitude]
      results = YelpSearchFacade.new(nil, params[:limit], params[:latitude], params[:longitude]).event_objects
    elsif params[:location]
      results = YelpSearchFacade.new(params[:location],params[:limit], nil, nil).event_objects
    end
    render json: EventSerializer.new(results)
  end
end