class EventService
  def get_events_by_zip(location, limit)
    res = conn.get("events?start_date=#{Time.now.to_i}&limit=#{limit}&location=#{location}&price=1")
    JSON.parse(res.body, symbolize_names: true)
  end

  def get_geo_events(latitude, longitude, limit)
    res = conn.get("events?start_date=#{Time.now.to_i}&limit=#{limit}&latitude=#{latitude}&longitude=#{longitude}&price=1") 
    JSON.parse(res.body, symbolize_names: true)
  end

  def find_by_id(event_id)
    res = conn.get("events/#{event_id}")
    JSON.parse(res.body, symbolize_names: true)
  end

  def find_current_events(location)
    res = conn.get("events?start_date=#{Time.now.to_i}&location=#{location}&limit=25")
    JSON.parse(res.body, symbolize_names: true)
  end

  private

  def get_geo_events(latitude, longitude, limit)
    res = conn.get("events?limit=#{limit}
                    &latitude=#{latitude}
                    &longitude=#{longitude}
                    &price=1") 
    JSON.parse(res.body, symbolize_names: true)
  end

  def conn = Faraday.new(url: "https://api.yelp.com/v3/") do |faraday|
    faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.yelp[:key]}"
  end
end
