require 'rails_helper'

describe "User Meetups API", type: :request do
  describe "User Meetups Index" do
    it "sends a list of the users meetups" do
      user = create(:user)

      meetup_list = create_list(:meetup, 5, user_id: user.id)
      
      meetup_list.each do |meetup|
        meetup.first_date = [true, false].sample
      end

      get api_v1_user_meetups_path(user.id, meetup_list)

      expect(response).to be_successful

      meetups = JSON.parse(response.body, symbolize_names: true)

      expect(meetups[:data].count).to eq(5)

      meetups[:data].each do |meet|
        expect(meetups).to be_a(Hash)
        expect(meetups[:data]).to be_an(Array)
        
        expect(meet).to have_key(:id)
        expect(meet[:id]).to be_an(String)
        
        expect(meet).to have_key(:attributes)
        
        expect(meet[:attributes]).to have_key(:title)
        expect(meet[:attributes][:title]).to be_a(String)

        expect(meet[:attributes]).to have_key(:location)
        expect(meet[:attributes][:location]).to be_a(String)

        expect(meet[:attributes]).to have_key(:start_time)
        expect(meet[:attributes][:start_time]).to be_a(String)

        expect(meet[:attributes]).to have_key(:end_time)
        expect(meet[:attributes][:end_time]).to be_a(String)

        expect(meet[:attributes]).to have_key(:first_date)
        expect(meet[:attributes][:first_date]).to be_a(TrueClass).or be_a(FalseClass)
      end
    end

    describe "Meetups Create" do
      it "can create a new meetup for user" do
        user = create(:user)
        meetup_params = ({
                        title: 'Park Picnic',
                        location: '80014',
                        start_time: '3:00 PM',
                        end_time: '6:00 PM',
                        first_date: true
                      })

        headers = {"CONTENT_TYPE" => "application/json"}
      
        post api_v1_user_meetups_path(user.id, meetup_params), params: (meetup_params)
        
        created_meetup = Meetup.last
  
        expect(response).to be_successful
        expect(created_meetup.title).to eq(meetup_params[:title])
        expect(created_meetup.location).to eq(meetup_params[:location])
        expect(created_meetup.start_time).to eq(meetup_params[:start_time])
        expect(created_meetup.end_time).to eq(meetup_params[:end_time])
        expect(created_meetup.first_date).to be(true).or be(false)
      end

      it 'sad path for create' do
        user = create(:user)
        meetup_params = ({
                        title: '',
                        location: '80014',
                        start_time: '3:00 PM',
                        end_time: '6:00 PM',
                        first_date: true
                      })

        headers = {"CONTENT_TYPE" => "application/json"}

        post api_v1_user_meetups_path(user.id, meetup_params), params: (meetup_params)
        
        expect(response).to_not be_successful
        expect(response).to have_http_status(401)
      end
    end
  end
end