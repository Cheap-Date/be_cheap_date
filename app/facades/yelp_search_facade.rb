class YelpSearchFacade
  # :bad_argument_error
  def initialize(location=nil, limit=25, latitude=nil, longitude=nil)
    @location = location
    @latitude = latitude
    @longitude = longitude
    @limit = limit
  end

  def event_search
    if @location
      json = EventService.new.get_events_by_zip(@location, @limit)
    elsif @latitude && @longitude
      json = EventService.new.get_geo_events(@latitude, @longitude, @limit)
    else
      # raise bad argument error
      json = "Didn't find any events"
    end
  end
  
  def event_objects
    event_search[:events].map do |event_data|
      Event.new(event_data)
    end
  end
end
