class TypeEquipment < ApplicationRecord
  has_many :brand_type_equipment, dependent: :destroy
  has_many :brand, through: :brand_type_equipment

  validates :name, presence: true
end
