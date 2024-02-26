class Event
  attr_reader :name, :location, :categories, :cost, :url
  
  def initialize(attributes)
    @name = attributes[:name]
    @location = attributes[:location][:display_address]
    @description = attributes[:description]
    @category = attributes[:category]
    @cost = attributes[:cost]
    @cost_max = attributes[:cost_max]
    @is_free = attributes[:is_free]
    @url = attributes[:events_site_url]
  end
end