class Stuff < ApplicationRecord
  belongs_to :user
  belongs_to :stuff_name

  has_many_attached :best_photos
  has_many_attached :trouble_photos

  validates :price, :quality, presence: true
end
