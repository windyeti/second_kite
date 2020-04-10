class Brand < ApplicationRecord
  has_many :brand_type_equipment, dependent: :destroy
  has_many :type_equipment, through: :brand_type_equipment

  validates :name, presence: true
end
