class EventSerializer
  # include JSONAPI::Serializer
  # attributes :name,
  #            :location, 
  #            :categories,
  #            :cost,
  #            :event_url
  def serialize_json(events)
    {
      "data": 
        events.each do |event|
          { 
            name: event.name,
            location: event.location,
            categories: event.categories,
            cost: event.cost,
            url: event.url
          }
        end
    }
  end
end