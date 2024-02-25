FactoryBot.define do
  factory :meetup do
    title { Faker::FunnyName.name }
    location { Faker::Address.zip }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end_time { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 3) }
    first_date { true }
  end
end