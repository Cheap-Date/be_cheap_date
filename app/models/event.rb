class Event < ApplicationRecord
  belongs_to :meetup

  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :cost, presence: true
  validates :cost_max, presence: true
  validates :is_free, presence: true
  validates :url, presence: true
end
