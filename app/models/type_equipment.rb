class TypeEquipment < ApplicationRecord
  has_many :brand_type_equipments, dependent: :destroy
  has_many :brands, through: :brand_type_equipments

  validates :name, presence: true
end
