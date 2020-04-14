# TODO Перезаполнить MyString
FactoryBot.define do
  factory :kite do
    user
    brand { "My Brand" }
    name { "My Name Kite" }
    year { "2012" }
    size { 14 }
    type { "" }
    sling_system { "MyString" }
    length_slim { "" }
    one_pump { false }
    price { 123 }
    quality { 4 }
    city { "MyString" }
    cargoable { false }
    origin_site { "MyString" }

    trait :invalid do
      brand { nil }
    end
  end
end
