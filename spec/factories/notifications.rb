FactoryBot.define do
  factory :notification do
    message { Faker::Games::Pokemon.name }
    is_read { false }
    user { nil }
  end
end
