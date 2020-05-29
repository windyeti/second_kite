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

  def self.custom_create(kite_params, current_user)
    transaction do
      new_params = custom_params(kite_params)
      kite = current_user.kites.create( new_params )
      kite
    end
  end

  def self.custom_params(kite_params)
    kite_name = KiteName.find_kite_name(kite_params)

    new_params = kite_params
    new_params.delete(:brand)
    new_params.delete(:madel)
    new_params[:kite_name] = kite_name
    new_params
  end

  def custom_update(kite_params)
    transaction do
      new_params = self.class.custom_params(kite_params)
      update( new_params )
      self
    end
  end

  # method for f.collection_check_boxes
  def kite_name_name
    if kite_name.approve
      "#{kite_name.name} - #{size}m2 - #{price}&#8381;".html_safe
    else
      "#{kite_name.name} - #{size}m2 - #{price}&#8381; need to approve".html_safe
    end
  end

  def brand
    kite_name.brand.name if kite_name
  end

  def madel
    kite_name.name if kite_name
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
