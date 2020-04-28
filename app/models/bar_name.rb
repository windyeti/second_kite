class BarName < ApplicationRecord
  belongs_to :brand

  has_many :bars, dependent: :destroy

  validates :name, presence: true
end
