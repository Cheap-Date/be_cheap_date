require "rails_helper"

RSpec.describe EventService, vcr: true do
  it "exists" do
    service = EventService.new

    expect(service).to be_an(EventService)
  end

  describe "methods" do
    it "has a .get_events method" do
      service = EventService.new.get_events(70117, 5)

      expect(service).to be_a(Hash)
    end

    it "has a .find_by_id method" do
      service = EventService.new.find_by_id("san-francisco-peace-love-and-yelp-our-3rd-annual-holiday-party")

      expect(service).to be_a(Hash)
    end
  end
end
