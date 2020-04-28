FactoryBot.define do
  factory :bar do
    user
    bar_name
    length { 1 }
    year { 1 }
    price { 1 }
    quality { 1 }
  end
end
