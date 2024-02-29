class YelpSearchFacade
  def initialize(location, limit)
    @location = location
    @limit = limit
  end

  def event_search
    if @location
      location = @location
    else
      location = "90210" # default value unless provided by user
    end

    service = EventService.new
    json = service.get_events(location, @limit)
    events = json[:events].map do |event_data|
      EventPoro.new(event_data)
    end
  end
end
