class BrandTypeEquipment < ApplicationRecord
  belongs_to :brand
  belongs_to :type_equipment
end
