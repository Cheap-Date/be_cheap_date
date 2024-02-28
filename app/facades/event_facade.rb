class EventFacade
  def event_by_id(id)
    service = EventService.new
    call = service.find_by_id(id)
    Event.new(call)
  end
end
