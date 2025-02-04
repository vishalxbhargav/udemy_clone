FactoryBot.define do
  factory :comment do
    body { "MyString" }
    answer { nil }
    user { nil }
  end
end
