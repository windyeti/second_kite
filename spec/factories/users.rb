FactoryBot.define do
  factory :user do
    email { "my@email.com" }
    password { '123456' }
    password_confirmation { '123456' }

    after(:create) do |user|
      user.confirm
    end
  end
end
