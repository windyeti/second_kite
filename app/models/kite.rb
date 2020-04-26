class Kite < ApplicationRecord
  belongs_to :user
  belongs_to :kite_name

  has_many :ad_kites, dependent: :destroy
  has_many :ads, through: :ad_kites

  has_many_attached :best_photos
  has_many_attached :trouble_photos

  validates :year, :size, :price, :quality, presence: true
  validates :year, :size, :price, :quality, numericality: true

  validates :quality, inclusion: 1..5

  validate :type_photos

  # method for f.collection_check_boxes
  def kite_name_name
    "#{kite_name.name} - #{size}m2 - #{price}&#8381;".html_safe
  end

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
