class Kite < ApplicationRecord
  belongs_to :user

  validates :brand, :name, :year, :size, :price, :quality, presence: true
  validates :year, :size, :price, :quality, numericality: true

  validates :quality, inclusion: 1..5
end
