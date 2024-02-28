class Api::V1::EventsController < ApplicationController
  # /api/v1/events
  def index
    results = YelpSearchFacade.new(params[:location], limit=25).event_search
    render json: EventSerializer.new(results)
  end

  def show
    event = EventFacade.new.event_by_id(params[:id])
    render json: EventSerializer.new(event)
  end
end
