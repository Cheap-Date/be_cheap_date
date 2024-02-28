require "rails_helper"

RSpec.describe "Api::V1::Events", vcr: true, type: :request do
  before(:each) do
    # Anyone old enough will recognize this as a Beverly Hills (i.e. a well-known and affluent section of Los Angeles
    @zip = "90210"
  end
  describe "GET /api/v1/events" do
    it "returns cheap YELP events given a `zipcode` and response `limit`", vcr: true do
      # /api/v1/events
      get "#{api_v1_events_path}?location=#{@zip}&price=1"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json_response[:data].count).to eq(25)

      # test that event search using zip code returns only those events from that region of the country
      # returning 25 events, the city will most likely change
      # the following ensures the events returned are all from the same state (** any outliers? >>> it's prob possible that a zip could return more than one state)
      # is there a better way to test??
      # events may get updated; would not provide reliable test results
      json_response[:data].each do |event|
        event[:attributes][:location].last.split(", ").last.split(" ").first == "CA"
      end

      # Change zipcode => 80212 covers an area in Denver, CO

      zip = "80212"

      # /api/v1/events
      # change to Colorado zip to confirm only events in CO are returned
      get "#{api_v1_events_path}?location=#{zip}&price=1"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json_response[:data].count).to eq(25)

      json_response[:data].each do |event|
        event[:attributes][:location].last.split(", ").last.split(" ").first == "CO"
      end
    end

    it "can return a single event by id", type: :request do
      get "#{api_v1_events_path}/san-francisco-peace-love-and-yelp-our-3rd-annual-holiday-party"

      expect(response).to be_successful

      event = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(event[:data][:attributes][:id]).to eq("san-francisco-peace-love-and-yelp-our-3rd-annual-holiday-party")
    end
  end
end
