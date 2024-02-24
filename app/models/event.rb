class Event < ApplicationRecord
  def initialize(attributes)
    @location = event_data[:location]
    @price = event_data[:price]
    @limit = event_data[:limit]
  end
end