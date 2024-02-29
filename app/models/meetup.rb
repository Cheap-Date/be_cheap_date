class Meetup < ApplicationRecord

  validates :title, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_date, presence: true

  belongs_to :user

  has_many :events
end
