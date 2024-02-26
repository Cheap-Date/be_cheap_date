class EventSerializer
  # TODO: Why does jsonapi_serializer gem throw => needs `id` attribute error
  #   even when ID is included as param and populated with hash returned by Yelp API??\
  #   Def pilot error. Would love answer since gem VERY convenient but I can't seem to use it?? - MATT DAR.

  # include JSONAPI::Serializer

  # attributes :name,
  #            :location, 
  #            :description,
  #            :category,
  #            :cost,
  #            :cost_max,
  #            :is_free,
  #            :url

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