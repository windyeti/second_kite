FactoryBot.define do
  factory :kite do
    title { "MyString" }
    total_price { 1.5 }
    year { 2012 }

    trait :invalid do
      title { nil }
    end
  end
end
