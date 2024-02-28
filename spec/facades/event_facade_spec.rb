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
end
