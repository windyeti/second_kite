class Brand < ApplicationRecord
  has_many :kite_names, dependent: :destroy

  validates :name, presence: true
end
