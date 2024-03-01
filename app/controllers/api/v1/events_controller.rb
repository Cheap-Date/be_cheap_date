class Api::V1::EventsController < ApplicationController
  # /api/v1/events
  def index
    # /api/v1/events
    location = event_params[:location]
    lat = event_params[:latitude]
    long = event_params[:longitude]


    # mostly only seen five-digit zips; start in USA where no alpha zip

    if location && location.to_s.match(/[0-9]+/).class && (location.to_s.length > 4 && location.to_s.length < 6)
      zip = location
      events = EventFacade.new.events_by_zip(zip)
      render json: EventSerializer.new(events)

    elsif location && location.match(/[a-zA-Z]+/)
      events = EventFacade.new.events_by_city_state(city_state)
      render json: EventSerializer.new(events)

    elsif location && EventFacade.new.valid_latitude_and_longitude?(lat, long) && (lat.to_f.class && long.to_f.class) == Float
      events = EventFacade.new.events_by_lat_and_long(lat, long)
      render json: EventSerializer.new(events)
      
    elsif !lat || !long && !location
      events = EventFacade.new.events_with_no_user_input 
      render json: EventSerializer.new(events)
    end

    def show
      event = EventFacade.new.event_by_id(event_params[:id])
      render json: EventSerializer.new(event)
    end
  end

  private

  def event_params
    params.permit(:id, :limit, :price, :start_date, :location, :latitude, :longitude, :radius)
  end
end