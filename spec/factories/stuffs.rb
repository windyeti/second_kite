FactoryBot.define do
  factory :stuff do
    user
    stuff_name
    price { 1 }
    quality { 1 }
    year { 1 }
    description { "MyText" }

    trait :invalid do
      year { nil }
    end
  end
end
