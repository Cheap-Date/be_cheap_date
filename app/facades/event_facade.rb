class EventFacade
  def event_by_id(id)
    service = EventService.new
    call = service.find_by_id(id)
    Event.new(call)
  end

  def current_events(location)
    service = EventService.new
    call = service.find_current_events(location)
    call[:events].map do |event|
      Event.new(event)
    end
  end
end
