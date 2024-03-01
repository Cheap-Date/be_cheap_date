class EventService
  def get_events(location, limit)
    res = conn.get("events?limit=#{limit}&location=#{location}&price=1")
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

  def conn = Faraday.new(url: "https://api.yelp.com/v3/") do |faraday|
    faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.yelp[:key]}"
  end
end
