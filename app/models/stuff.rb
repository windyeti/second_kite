class Stuff < ApplicationRecord
  belongs_to :user
  belongs_to :stuff_name

  has_many :ad_stuffs, dependent: :destroy
  has_many :ads, through: :ad_stuffs

  has_many_attached :best_photos
  has_many_attached :trouble_photos

  validates :price, :quality, presence: true
  validates :quality, inclusion: 1..5

  validate :type_photos

  # method for f.collection_check_boxes
  def stuff_name_name
    short = description.truncate(20)
    "#{stuff_name.name} - #{short} - #{price}&#8381;".html_safe
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
