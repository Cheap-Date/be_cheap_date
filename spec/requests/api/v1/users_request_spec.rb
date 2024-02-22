require 'rails_helper' 

RSpec.describe 'Api::V1::Users', type: :request do
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
end