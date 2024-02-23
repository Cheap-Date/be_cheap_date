class EventSerializer
  # include JSONAPI::Serializer
  # attributes :id, :name, :location

  def serialize_json(events)
    {
      "data": 
        events.each do |event|
          { name: event[:name], location: event[:location] }
        end
    }
  end
end