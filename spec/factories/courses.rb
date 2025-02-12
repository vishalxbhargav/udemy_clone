FactoryBot.define do
  factory :course do
    title { "I thought DatabaseCleaner would revert the changes, but it looks like the user record persist in the database till the second scenario block." }
    description { "I thought DatabaseCleaner would revert the changes, but it looks like the user record persist in the database till the second scenario block." }
    price { 9999 }
  end
end
