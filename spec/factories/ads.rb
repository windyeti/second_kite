FactoryBot.define do
  factory :ad do
    title { "MyString" }
    description { "MyText" }
    total_price { 1.5 }
    user

    trait :invalid do
      title { nil }
    end
  end
end
