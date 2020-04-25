class Board < ApplicationRecord
  belongs_to :user
  belongs_to :board_name

  has_many_attached :best_photos
  has_many_attached :trouble_photos

  validates :length, :width, :year, :quality, :price, presence: true
  validates :length, :width, :year, :quality, :price, numericality: true

  validates :quality, inclusion: 1..5

  validate :type_photos

  private

  def type_photos
    [best_photos, trouble_photos].each do |photos|
      photos.each do |photo|
        if !photo.content_type.in?(%('image/jpeg image/png'))
          errors.add(:photo, "needs to be a jpeg or png!")
        end
      end
    end
  end
end
