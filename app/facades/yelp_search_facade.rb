class YelpSearchFacade
  def initialize(attributes)
    @location = attributes[:location]
    @price = attributes[:price]
    @limit = attributes[:limit]
  end

  def search_results
    event_service = EventService.new
    res = event_service.get_all_events(@location, @price, @limit)
  end

  def parsed_results
    result = search_results.map do |event_obj|
      {
        name: event_obj[:name],
        location: event_obj[:location][:display_address]
      }
    end
  end
end