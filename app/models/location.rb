class Location < ApplicationRecord
  belongs_to :user
  validates :latitude, presence: true
  validates :longitude, presence: true
end
