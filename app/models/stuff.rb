class Stuff < ApplicationRecord
  belongs_to :user
  belongs_to :stuff_name

  has_many :ad_stuffs, dependent: :destroy
  has_many :ads, through: :ad_stuffs

  has_many_attached :best_photos
  has_many_attached :trouble_photos

  validates :price, :quality, :year, presence: true
  validates :quality, inclusion: 1..5

  validate :type_photos

  # '+++++++++++++++++++++++++'
  def self.custom_create(stuff_params, current_user)
    transaction do
      new_params = custom_params(stuff_params)
      stuff = current_user.stuffs.create( new_params )
      stuff
    end
  end

  def self.custom_params(stuff_params)
    stuff_name = StuffName.find_stuff_name(stuff_params)

    new_params = stuff_params
    new_params.delete(:brand)
    new_params.delete(:madel)
    new_params[:stuff_name] = stuff_name
    new_params
  end

  def custom_update(stuff_params)
    transaction do
      new_params = self.class.custom_params(stuff_params)
      update( new_params )
      self
    end
  end
  # '+++++++++++++++++++++++++'

  # method for f.collection_check_boxes
  def stuff_name_name
    short = description.truncate(20)
    if stuff_name.approve
      "#{stuff_name.name} - #{short} - #{price}&#8381;".html_safe
    else
      "#{stuff_name.name} - #{short} - #{price}&#8381; need to approve".html_safe
    end
  end

  def brand
    stuff_name.brand.name if stuff_name
  end

  def madel
    stuff_name.name if stuff_name
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
