FactoryBot.define do
  factory :board do
    user
    board_name
    width { 1 }
    length { 1 }
    year { 1 }
    quality { 1 }
    price { 1 }
  end
end
