FactoryBot.define do
  factory :account do
    user
    nickname { "MyNick" }
    phone { "+7 977 960 60 60" }
    city { "Moscow" }
  end
end
