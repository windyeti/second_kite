class BarName < ApplicationRecord
  include Subscriptionable

  belongs_to :brand

  has_many :bars, dependent: :destroy

  validates :name, presence: true
end
