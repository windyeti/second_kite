class BoardName < ApplicationRecord
  include Subscriptionable

  belongs_to :brand

  has_many :boards

  validates :name, presence: true
end
