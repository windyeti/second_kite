class StuffName < ApplicationRecord
  belongs_to :brand

  has_many :stuffs, dependent: :destroy

  validates :name, presence: true
end
