class KiteName < ApplicationRecord
  include Subscriptionable

  belongs_to :brand

  has_many :kites

  validates :name, presence: true
end
