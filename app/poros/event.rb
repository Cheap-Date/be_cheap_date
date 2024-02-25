class Event
  attr_reader :name, :location, :categories, :cost, :url
  
  def initialize(attributes)
    @name = attributes[:name]
    @location = attributes[:location][:display_address]
    @categories = attributes[:categories]
    @cost = attributes[:price]
    @url = attributes[:url]
  end
end