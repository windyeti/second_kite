FactoryBot.define do
  factory :kite do
    user
    kite_name
    year { 2012 }
    size { 14 }
    price { 340 }
    quality { 4 }

    trait :invalid do
      year { nil }
    end
  end
end
