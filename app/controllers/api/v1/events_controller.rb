class Api::V1::EventsController < ApplicationController
  # /api/v1/events
  def index
    # /api/v1/events
    if params[:latitude] && params[:longitude]
      results = YelpSearchFacade.new(nil, params[:limit], params[:latitude], params[:longitude]).event_objects
    elsif params[:location]
      results = YelpSearchFacade.new(params[:location],params[:limit], nil, nil).event_objects
    end
    render json: EventSerializer.new(results)
  end

  def show
    event = EventFacade.new.event_by_id(event_params[:id])
    render json: EventSerializer.new(event)
  end

  private

  def event_params
    params.permit(:id, :location)
  end
end
