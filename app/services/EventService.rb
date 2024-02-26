require "faraday"

class EventService
  def get_events(location, limit)
    res = conn.get("events?limit=#{limit}&location=#{location}&price=1")
    JSON.parse(res.body, symbolize_names: true)
  end

  def conn = Faraday.new(url: "https://api.yelp.com/v3/") do |faraday|
    faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.yelp[:key]}"
  end
end