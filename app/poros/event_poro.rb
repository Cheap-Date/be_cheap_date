class EventPoro
  attr_reader :id, :name, :limit, :location, :description, :category, :cost, :cost_max, :is_free, :url

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @location = attributes[:location][:display_address]
    @description = attributes[:description]
    @category = attributes[:category]
    @cost = attributes[:cost]
    @cost_max = attributes[:cost_max]
    @is_free = attributes[:is_free]
    @url = attributes[:event_site_url]
    @limit = attributes[:limit]
  end
end
