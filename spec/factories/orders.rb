FactoryBot.define do
  factory :order do
    user { nil }
    course { nil }
    status { 1 }
    transaction_id { "MyString" }
  end
end
