require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations and associations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email)}
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    it { should validate_presence_of(:password_digest)}
    it { should have_many(:meetups) }
    it { should have_many(:events).through(:meetups) }
  end

  describe 'has_secure_password' do
    it { should have_secure_password }
  end
end
