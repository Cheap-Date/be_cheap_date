require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations and associations' do
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should belong_to(:user) }
  end
  
  it 'is valid with valid latitude and longitude' do
    user = create(:user)
    location = build(:location, user: user)
    expect(location).to be_valid
  end

  it 'is invalid without a latitude' do
    location = build(:location, latitude: nil)
    location.valid?
    expect(location.errors[:latitude]).to include("can't be blank")
  end

  it 'is invalid without a longitude' do
    location = build(:location, longitude: nil)
    location.valid?
    expect(location.errors[:longitude]).to include("can't be blank")
  end

  it 'belongs to a user' do
    location = build(:location)
    expect(location.user).to be_a(User)
  end
end
