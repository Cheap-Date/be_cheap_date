require 'rails_helper'

RSpec.describe EventPoro, type: :model do
  describe 'initialize' do
    it 'sets the instance variables' do
      attr = {
        id: 1,
        name: 'Event Name',
        location: { display_address: 'Event Location' },
        description: 'Event Description',
        category: 'Event Category',
        cost: 10.00,
        cost_max: 20.00,
        is_free: false,
        event_site_url: 'https://example.com'
      }

      event = EventPoro.new(attr)

      expect(event.id).to eq(1)
      expect(event.name).to eq('Event Name')
      expect(event.location).to eq('Event Location')
      expect(event.description).to eq('Event Description')
      expect(event.category).to eq('Event Category')
      expect(event.cost).to eq(10.00)
      expect(event.cost_max).to eq(20.00)
      expect(event.is_free).to eq(false)
      expect(event.url).to eq('https://example.com')
    end
  end
end
