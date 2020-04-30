class Stuff < ApplicationRecord
  belongs_to :user
  belongs_to :stuff_name

  validates :price, :quality, presence: true
end
