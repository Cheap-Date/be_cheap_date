require 'rails_helper'

RSpec.describe YelpSearchFacade, vcr: true do
  describe '#event_search' do
    context 'when the location parameter is not provided' do
      it 'uses the default value of "90210"' do
        facade = YelpSearchFacade.new(nil, 10)

        expect(facade.event_search).to be_a(Array)
      end
    end
  end
end
