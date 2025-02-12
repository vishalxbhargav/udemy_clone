FactoryBot.define do
  factory :user do
    first_name{ Faker::Name.first_name }
    last_name{ Faker::Name.last_name }
    email{Faker::Internet.email }
    username{Faker::Internet.username}
    role{1}
    password{"1232432423"}
  end
end
