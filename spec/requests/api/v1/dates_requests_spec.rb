require 'rails_helper'

describe "Dates API", type: :request do
  describe "Dates Index" do
    xit "sends a list of dates" do
      user = create(:user)
      date_list = create_list(:date, 5, user: user)

      get api_v1_user_dates_path(user.id, date_list)

      expect(response).to be_successful

      dates = JSON.parse(response.body, symbolize_names: true)

      expect(dates[:data].count).to eq(5)

      dates[:data].each do |date|
        expect(dates).to be_a(Hash)
        expect(dates[:data]).to be_an(Array)
        
        expect(date).to have_key(:id)
        expect(date[:id]).to be_an(String)
        
        expect(date).to have_key(:attributes)
        
        expect(date[:attributes]).to have_key(:title)
        expect(date[:attributes][:title]).to be_a(String)

        expect(date[:attributes]).to have_key(:location)
        expect(date[:attributes][:location]).to be_a(Integer)

        expect(date[:attributes]).to have_key(:start_time)
        expect(date[:attributes][:start_time]).to be_a(Integer)

        expect(date[:attributes]).to have_key(:end_time)
        expect(date[:attributes][:end_time]).to be_a(Integer)

        expect(date[:attributes]).to have_key(:first_date)
        expect(date[:attributes][:first_date]).to be_a(TrueClass).or be_a(FalseClass)
      end
    end
  end
end