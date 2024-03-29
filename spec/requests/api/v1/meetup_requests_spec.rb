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

    describe "Meetup Update" do
      it "can update an existing date" do
        user = create(:user)
        meetup = create(:meetup, user: user)
        previous_title = Meetup.last.title
        meetup_param = { title: "Dance Class" }
        headers = {"CONTENT_TYPE" => "application/json"}
  
        patch api_v1_user_meetup_path(user.id, meetup.id), params: meetup_param
        new_meetup = Meetup.find(meetup.id)
        expect(response).to be_successful
        expect(new_meetup.title).to_not eq(previous_title)
        expect(new_meetup.title).to eq("Dance Class")
      end
  
      it "sad path; will send an error if meetup is not created" do 
        user = create(:user)
        meetup = create(:meetup, user: user)
        previous_title = Meetup.last.title
        meetup_param = { title: "" }
        headers = {"CONTENT_TYPE" => "application/json"}
    
        patch api_v1_user_meetup_path(user.id, meetup.id), params: meetup_param
        expect(response).to_not be_successful 
        expect(response).to have_http_status(422)
      end
    end

    describe "Meetup Destroy" do
      it "can destroy an meetup" do
        user = create(:user)
        meetup = create(:meetup, user: user)
      
        expect(Meetup.count).to eq(1)
      
        delete api_v1_user_meetup_path(user.id, meetup.id)
      
        expect(response).to be_successful
        expect(Meetup.count).to eq(0)
        expect{Meetup.find(meetup.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "Meetup Show" do
      it "can get one Meetup by its id" do
        user = create(:user)
        meetup = create(:meetup, user: user)
        
        get api_v1_user_meetup_path(user.id, meetup.id)
  
        meetup_request = JSON.parse(response.body, symbolize_names: true) 
  
        expect(response).to be_successful
        expect(meetup_request).to be_a(Hash)
        
        expect(meetup_request[:data]).to have_key(:id)
        expect(meetup_request[:data][:id]).to be_an(String)
    
        expect(meetup_request[:data][:attributes]).to have_key(:title)
        expect(meetup_request[:data][:attributes][:title]).to be_a(String)
    
        expect(meetup_request[:data][:attributes]).to have_key(:location)
        expect(meetup_request[:data][:attributes][:location]).to be_a(String)
  
        expect(meetup_request[:data][:attributes]).to have_key(:start_time)
        expect(meetup_request[:data][:attributes][:start_time]).to be_a(String)
  
        expect(meetup_request[:data][:attributes]).to have_key(:end_time)
        expect(meetup_request[:data][:attributes][:end_time]).to be_a(String)
  
        expect(meetup_request[:data][:attributes]).to have_key(:first_date)
        expect(meetup_request[:data][:attributes][:first_date]).to be_a(TrueClass).or be_a(FalseClass)
      end
    end
  end
end