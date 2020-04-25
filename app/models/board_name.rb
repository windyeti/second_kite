class BoardName < ApplicationRecord
  belongs_to :brand

  has_many :boards

  validates :name, presence: true
end
