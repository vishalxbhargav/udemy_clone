FactoryBot.define do
  factory :question do
    title { Faker::JapaneseMedia::OnePiece.character }
    description { Faker::JapaneseMedia::OnePiece.location #=> "Foosha Village"
  }
    user { nil }
    forume { nil }
  end
end
