FactoryBot.define do
  factory :kite do
    user
    kite_name
    year { 2012 }
    size { 14 }
    price { 340 }
    quality { 4 }

    trait :invalid do
      kite_name { nil }
    end
  end
end
