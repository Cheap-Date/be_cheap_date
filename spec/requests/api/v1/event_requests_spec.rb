require "rails_helper"

RSpec.describe "Api::V1::Events", type: :request do 
  describe "GET /api/v1/events" do
    it "returns cheap YELP events local to the area provided by zip" do
      zip = "80111"

      get "#{api_v1_events_path}?location=#{zip}"
      
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body, symbolize_names: true)
    end
  end
end