FactoryBot.define do
  factory :notification do
    message { "MyString" }
    is_read { false }
    user { nil }
  end
end
