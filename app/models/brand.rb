class Brand < ApplicationRecord
  has_many :brand_type_equipments, dependent: :destroy
  has_many :type_equipments, through: :brand_type_equipments

  validates :name, presence: true
end
