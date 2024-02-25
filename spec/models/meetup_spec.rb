require 'rails_helper'

RSpec.describe Meetup, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:location)}
    it { should validate_presence_of(:start_time)}
    it { should validate_presence_of(:end_time)}
    it { should validate_presence_of(:first_date)}
    it { should belong_to(:user) }
  end
end