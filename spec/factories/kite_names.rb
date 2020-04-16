FactoryBot.define do
  factory :kite_name do
    brand
    name { "My Kite" }

    trait :invalid do
      name { nil }
    end
  end
end
