class Brand < ApplicationRecord
  has_many :kite_names, dependent: :destroy
  has_many :board_names, dependent: :destroy
  has_many :bar_names, dependent: :destroy

  validates :name, presence: true
end
