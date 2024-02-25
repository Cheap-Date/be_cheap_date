class YelpSearchFacade
  def initialize(location, limit)
    @location = location
    @limit = limit
  end

  def event_search
    service = EventService.new
    json = service.get_events(@location, @limit)
    events = json.map do |event_data|
      Event.new(event_data)
    end
  end
end