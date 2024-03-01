require "rails_helper"

RSpec.describe Event, type: :model do
  describe "associations" do
    it { should belong_to(:meetup) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:category) }
    # it { should validate_presence_of(:cost) }
    # it { should validate_presence_of(:cost_max) }
    it { should validate_presence_of(:is_free) }
    it { should validate_presence_of(:url) }
  end
end
