FactoryBot.define do
  factory :answer do
    body { "MyString" }
    user { nil }
    question { nil }
  end
end
