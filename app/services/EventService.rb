class EventService
  # have some fun when a user doesn't input any location parameters
  def gobblers_knob_events
    res = conn.get("events?&limit=10&location=gobbler's knob, pa&radius=40000&start_time=#{Time.now.to_i}")
    JSON.parse(res.body, symbolize_names: true)
  end

  def find_by_zip(zip, limit=10)
    res = conn.get("events?start_date=#{Time.now.to_i}&limit=25&location=#{zip}&price=1&radius=40000")
    JSON.parse(res.body, symbolize_names: true)
  end

  def find_by_lat_and_long(lat, long)
    res = conn.get("events?start_date=#{Time.now.to_i}&limit=25&latitude=#{lat}&longitude=#{long}&price=1&radius=40000") 
    JSON.parse(res.body, symbolize_names: true)
  end

  def find_by_id(event_id)
    res = conn.get("events/#{event_id}")
    JSON.parse(res.body, symbolize_names: true)
  end

  def find_by_city_state(city_state)
    res = conn.get("events?start_date=#{Time.now.to_i}&location=#{city_state
    }&limit=25")
    JSON.parse(res.body, symbolize_names: true)
  end

  private

  def conn = Faraday.new(url: "https://api.yelp.com/v3/") do |faraday|
    faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.yelp[:key]}"
  end
end
