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

  describe "User Update" do
    it "can update an existing user" do
      user_params = ({
        name: 'Bob Dylan',
        email: 'bob123@gmail.com',
        password: "likearollingstone123"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_users_path, headers: headers, params: JSON.generate(user: user_params)

      id = User.last.id
      previous_name = User.last.name
      expect(previous_name).to eq("Bob Dylan")

      user_params = { name: "Paul McCartney" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/users/#{id}", headers: headers, params: JSON.generate(user: user_params)

      user = User.find_by(id: id)

      expect(response).to be_successful
      expect(user.name).to_not eq(previous_name)
      expect(user.name).to eq("Paul McCartney")
    end

    context 'when request is invalid' do
      it 'returns unprocessable entity' do
        user = User.create!(name: 'Initial Name', email: 'initial@example.com', password: 'password123')

        patch "/api/v1/users/#{user.id}", params: { user: { name: '' } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('name')
      end
    end
  end

  describe 'Find user by email' do
    it 'can login a user' do
      user = User.create!(name: 'Bob Dylan', email: 'bob123@gmail.com', password: "likearollingstone123")

      get api_v1_find_by_email_path, params: { email: user.email, password: user.password }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(json[:data][:attributes][:name]).to eq('Bob Dylan')

    end

    it 'sad path for user login, wrong password' do
      user = User.create!(name: 'Bob Dylan', email: 'bob123@gmail.com', password: "likearollingstone123")

      get api_v1_find_by_email_path, params: { email: user.email, password: 'wrong_password' }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(json[:error]).to eq('Sorry, your credentials are bad')
    end

    it 'sad path for user login, wrong email' do
      user = User.create!(name: 'Bob Dylan', email: 'bob123@gmail.com', password: "likearollingstone123")

      get api_v1_find_by_email_path, params: { email: 'wrong_email', password: user.password }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(json[:error]).to eq('This email is not associated with an account')
    end
  end

  describe 'User destroy' do
    it 'can destroy an user' do
      user = create(:user)

      expect(User.count).to eq(1)

      delete api_v1_user_path(user.id)

      expect(response).to be_successful
      expect(User.count).to eq(0)
      expect{User.find(user.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
