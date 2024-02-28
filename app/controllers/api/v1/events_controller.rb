class Api::V1::EventsController < ApplicationController
  # /api/v1/events
  def index
    results = EventFacade.new.current_events(params[:location])
    render json: EventSerializer.new(results)
  end

  def show
    event = EventFacade.new.event_by_id(params[:id])
    render json: EventSerializer.new(event)
  end
end
