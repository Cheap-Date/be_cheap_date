class Api::V1::EventsController < ApplicationController
  def index
    results = YelpSearchFacade.new(params[:location], params[:limit]).event_search
    render json: EventSerializer.new.serialize_json(results)
  end
end