require 'rails_helper' 

RSpec.describe 'Api::V1::Users', type: :request do
  describe "Users Index" do
    it "sends a list of users" do
      create_list(:user, 5)

      get api_v1_users_path

      expect(response).to be_successful

      users_data = JSON.parse(response.body, symbolize_names: true)
      users = users_data[:data]
      expect(users.count).to eq(5)

      users.each do |user|
        expect(users).to be_an(Array)

        expect(user).to have_key(:id)
        expect(user[:id]).to be_an(String)

        expect(user[:attributes]).to have_key(:name)
        expect(user[:attributes][:name]).to be_a(String)

        expect(user[:attributes]).to have_key(:email)
        expect(user[:attributes][:email]).to be_a(String)

      end
    end
  end

  describe "Users Show" do
    it 'displays the users information' do
      user = create(:user)
      id = user.id

      get api_v1_user_path(id)

      expect(response).to be_successful

      user = JSON.parse(response.body, symbolize_names: true)
      user_data = user[:data]
      user_object = user[:data][:attributes]
      expect(user).to be_a(Hash)
      
      expect(user_data).to have_key(:id)
      expect(user_data[:id]).to be_an(String)
    
      expect(user_object).to have_key(:name)
      expect(user_object[:name]).to be_an(String)

      expect(user_object).to have_key(:email)
      expect(user_object[:email]).to be_an(String)

    end
  end

  describe "Users Create" do
    it 'creates a user' do
      user_params = ({
        name: 'Bob Dylan',
        email: 'bob123@gmail.com',
        password: "likearollingstone123"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_users_path, headers: headers, params: JSON.generate(user: user_params)

      new_user = User.last

      expect(response).to be_successful
      expect(new_user.name).to eq(user_params[:name])
      expect(new_user.email).to eq(user_params[:email])
      expect(new_user.password).to eq(user_params[:password_digest])
    end

    it "sad path; will send an error if user is not created" do 
      user_params = ({
        name: '',
        email: 'bob123@gmail.com',
        role: 1,
        password: "likearollingstone123"
      })
      
      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_users_path, headers: headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful 
      expect(response).to have_http_status(401)
    end
  end
end