FactoryBot.define do
  factory :user do
    name { Faker::Name.user_name }
    email { Faker::Internet.unique.email }
    password { Faker::Alphanumeric.alpha(number: 15) }
  end
end