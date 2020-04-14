FactoryBot.define do
  sequence :name do |n|
    "My Type equipment #{n}"
  end
  factory :type_equipment do
    name
    trait :invalid do
      name { nil }
    end
  end
end
