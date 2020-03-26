FactoryBot.define do
  factory :user do
    email { "My email" }
    password { '123456' }
    password_confirmation { '123456' }

    after(:create) { |user| user.confirm }
  end
end
