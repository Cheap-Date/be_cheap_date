class EventFacade
  def event_by_id(id)
    service = EventService.new
    call = service.find_by_id(id)
    EventPoro.new(call)
  end

  def events_by_zip(zip)
    service = EventService.new
    call = service.find_by_zip(zip)
    event_poros = create_event_poros(call)
  end

  def current_events(location)
    service = EventService.new
    call = service.find_current_events(location)
    call[:events].map do |event|
      EventPoro.new(event)
    end
  end

  def events_by_lat_and_long(lat, long)
    service = EventService.new
    call = service.find_by_lat_and_long(lat, long)
    event_poros = create_event_poros(call)
  end

  def events_by_city_state(city_state)
    service = EventService.new
    call = service.find_by_city_state(city_state)
  end

  def events_with_no_user_input
    service = EventService.new
    call = service.gobblers_knob_events
    event_poros = create_event_poros(call)
  end

  def valid_latitude_and_longitude?(val)
    pattern = /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/
    return val.match(pattern)
  end

  # private

  def create_event_poros(api_response)
    api_response[:events].map do |event|
      EventPoro.new(event)
    end
  end
end
