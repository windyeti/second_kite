class KiteName < ApplicationRecord
  belongs_to :brand

  has_many :kites

  validates :name, presence: true
end
