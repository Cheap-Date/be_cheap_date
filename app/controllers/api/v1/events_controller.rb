class Api::V1::EventsController < ApplicationController
  # /api/v1/events
  def index
    results = EventFacade.new.current_events(event_params[:location])
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
