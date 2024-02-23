class YelpSearchFacade
  def initialize(location, price="1")
    @location = location
    @price = price
  end

  def search_results
    event_service = EventService.new
    res = event_service.get_all_events(@location, @price)
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