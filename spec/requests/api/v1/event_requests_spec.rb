require "rails_helper"

RSpec.describe "Api::V1::Events", type: :request do
  before(:each) do

    # Anyone old enough will recognize this as a Beverly Hills (i.e. a well-known and affluent section of Los Angeles

    @zip = "90210"
    @limit = 7
  end
  describe "GET /api/v1/events" do
    it "returns cheap YELP events given a `zipcode` and response `limit`", :vcr do
      get "#{api_v1_events_path}?location=#{@zip}&price=1&limit=#{@limit}"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json_response[:data].count).to eq(7)

      json_response[:data].each do |event|
        expect(event[:location].last.split(", ").first) == "Los Angeles"
      end

      # Change zipcode and limit. 80212 covers an area in Denver, CO

      @zip = "80212"
      @limit = 4

      get "#{api_v1_events_path}?location=#{@zip}&price=1&limit=#{@limit}"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json_response[:data].count).to eq(4)

      json_response[:data].each do |event|
        expect(event[:location].last.split(", ").first) == "Denver"
      end
    end
  end
end