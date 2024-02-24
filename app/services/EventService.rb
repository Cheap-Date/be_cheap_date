require "faraday"

class EventService
  def get_all_events(location, price, limit)
    res = conn.get("businesses/search?sort_by=best_match&location=#{location}&limit=#{limit}&price=#{price}")
    JSON.parse(res.body, symbolize_names: true)[:businesses]
  end

  def conn = Faraday.new(url: "https://api.yelp.com/v3/") do |faraday|
    faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.yelp[:key]}"
  end
end