require "rails_helper"

RSpec.describe EventFacade, vcr: true do
  it "exists" do
    facade = EventFacade.new

    expect(facade).to be_a(EventFacade)
  end

  it "has an #event_by_id method" do
    facade = EventFacade.new.event_by_id("san-francisco-peace-love-and-yelp-our-3rd-annual-holiday-party")

    expect(facade).to be_an(Event)
  end

  describe "#current_events", vcr: false do
    before do
      VCR.turn_off!(ignore_cassettes: true)
      WebMock.allow_net_connect!
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!(allow_localhost: true)
    end

    it "has a current_events method" do
      facade = EventFacade.new.current_events(70117)

      expect(facade).to be_an(Array)
      expect(facade.first).to be_an(Event)
    end
  end
end
