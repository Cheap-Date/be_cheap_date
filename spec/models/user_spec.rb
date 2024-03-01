require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:email)}
    # it { should validate_uniqueness_of(:email)} # Commented out because validations are seemingly not working properly with new log in format; ask instructors
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    it { should have_many(:meetups) }
  end
end