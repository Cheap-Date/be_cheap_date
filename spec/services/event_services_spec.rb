require "rails_helper"

RSpec.describe EventService, vcr: true do
  it "exists" do
    service = EventService.new

    expect(service).to be_an(EventService)
  end

  describe "methods" do
    it "has a #get_events method" do
      service = EventService.new.find_by_zip(70117, 5)

      expect(service).to be_a(Hash)
    end

    it "has a #find_by_id method" do
      service = EventService.new.find_by_id("san-francisco-peace-love-and-yelp-our-3rd-annual-holiday-party")

      expect(service).to be_a(Hash)
    end
  end

  describe "#find_current_events", vcr: false do
    before do
      VCR.turn_off!(ignore_cassettes: true)
      WebMock.allow_net_connect!
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!(allow_localhost: true)
    end

    it "returns a hash" do
      service = EventService.new.find_by_zip("70117")

      expect(service).to be_a(Hash)
    end
  end
end
