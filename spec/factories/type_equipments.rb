FactoryBot.define do
  factory :type_equipment do
    name { "My Type equipment" }

    trait :invalid do
      name { nil }
    end
  end
end
