FactoryBot.define do
  factory :ad do
    title { "MyString" }
    description { "MyText" }
    total_price { 1.5 }
    user { nil }

    trait :invalid do
      title { nil }
    end
  end
end
