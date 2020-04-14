FactoryBot.define do
  factory :brand do
    name { "My Brand" }
    type_equipment_ids { [ create(:type_equipment).id, create(:type_equipment).id ] }
  end
end
