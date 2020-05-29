FactoryBot.define do
  factory :kite do
    user
    kite_name
    # brand { nil }
    # madel { nil }
    year { 2012 }
    size { 14 }
    price { 340 }
    quality { 4 }

    trait :invalid do
      year { nil }
    end

    trait :with_attachments do
      after(:create) do |kite|
        kite.best_photos.attach [io: File.open(Rails.root.join('spec', 'support', 'test_red.jpg')), filename: 'test_red.jpg']
        # kite.best_photos.attach [fixture_file_upload(Rails.root.join('spec', 'support', 'test_red.jpg'), 'image/jpeg')]
      end
    end
  end
end
