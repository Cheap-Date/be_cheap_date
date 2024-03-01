require "rails_helper"

RSpec.describe EventFacade, vcr: true do
  before(:each) do 
    @yelp_query_no_location = {
      location: nil,
      latitude: nil,
      longitude: nil
    }
    @yelp_query_zip = {
      location: 90210,
      latitude: nil,
      longitude: nil
    }
  end

  describe '#empty_query_values' do
    describe 'what is returned when a user does not enter any query arguments' do
      it 'displays events from Gobbler\'s Knob, PA, along with a string that alerting user they did not enter any search params' do
        json_response = File.read('spec/fixtures/custom_json/events_no_query_params.json')
        stubbed = stub_http_request(:get, "http://localhost:3000/api/v1/events?start_time=#{Time.now.to_i}&limit=10&price=1")
            .to_return(status: 200, body: json_response)
        # returns the 10 events from Gobbler's Knob.
        # every method in the EventFacade class will be returned as a PORO array
        facade = EventFacade.new.events_with_no_user_input
        # shows that values returned from the response body => which stores the JSON file - copied directly from Postman and pasted, 
        # with no changes, to this fixture file: 'spec/fixtures/custom_json/events_no_query_params.json'
        # that fixture file is being saved to the json_response variable, which is actually the same pointer returned from the stub_http_request.
        # this is precisely why the second test works. it also shows variables hoding the same data can be parsed, serialized, and parsed again without
        # their values ever being affected; neither of those methods are destructive and can't  be undone.
        EventFacade.new.create_event_poros(JSON.parse(stubbed.response.body, symbolize_names: true)) == facade
        expect(json_response).to eq(stubbed.response.body)

        # sad path when user didn't enter zip or geolocation in event search
      end
    end

    context 'when the location parameter is provided' do
      it "uses the location parameter's value to search for matching data on the API" do
        res = EventFacade.new.events_by_city_state('San Francisco')
        expect(res[:events].count).to eq(25)
        res[:events].each do |event_attr|
          event_attr[:location][:city] == "San Francisco"
        end
      end
    end
  end
  it "exists" do
    facade = EventFacade.new

    expect(facade).to be_a(EventFacade)
  end

  it "has an #event_by_id method" do
    facade = EventFacade.new.event_by_id("san-francisco-peace-love-and-yelp-our-3rd-annual-holiday-party")

    expect(facade).to be_an(EventPoro)
  end

  describe "#events_by_zip_code", vcr: false do
    before do
      VCR.turn_off!(ignore_cassettes: true)
      WebMock.allow_net_connect!
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!(allow_localhost: true)
    end

    it "can find current events by zip code" do
      facade = EventFacade.new.events_by_zip(70117)

      expect(facade).to be_an(Array)
      expect(facade.first).to be_an(EventPoro)
    end
  end
end
