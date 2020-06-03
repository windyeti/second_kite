FactoryBot.define do
  factory :ad do
    title { "MyString" }
    description { "MyText" }
    total_price { 1.5 }
    user
    kite_ids { [""] }
    board_ids { [""] }
    bar_ids { [""] }
    stuff_ids { [""] }

    trait :invalid do
      title { nil }
    end
  end
end
