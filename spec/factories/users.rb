FactoryBot.define do
  factory :user do
    first_name{ Faker::Name.first_name }
    last_name{ Faker::Name.last_name }
    email{Faker::Internet.email }
    username{Faker::Internet.username}
    password{"1232432423"}
    
    trait :Instructor do
      role{:Instructor}
    end
    trait :Admin do
      role{:Admin}
    end
  end
end
