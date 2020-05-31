class Bar < ApplicationRecord
  belongs_to :user
  belongs_to :bar_name

  has_many :ad_bars, dependent: :destroy
  has_many :ads, through: :ad_bars

  has_many_attached :best_photos
  has_many_attached :trouble_photos

  validates :length, :price, :quality, :year, presence: true

  validates :quality, inclusion: 1..5

  validate :type_photos

  # +++++++++++++++++++++++++++++++
  def self.custom_create(bar_params, current_user)
    transaction do
      new_params = custom_params(bar_params)
      bar = current_user.bars.create( new_params )
      bar
    end
  end

  def self.custom_params(bar_params)
    bar_name = BarName.find_bar_name(bar_params)

    new_params = bar_params
    new_params.delete(:brand)
    new_params.delete(:madel)
    new_params[:bar_name] = bar_name
    new_params
  end

  def custom_update(bar_params)
    transaction do
      new_params = self.class.custom_params(bar_params)
      update( new_params )
      self
    end
  end
  # +++++++++++++++++++++++++++++++

  # method for f.collection_check_boxes
  def bar_name_name
    if bar_name.approve
      "#{bar_name.name} - #{length}см - #{price}&#8381;".html_safe
    else
      "#{bar_name.name} - #{length}см - #{price}&#8381; need to approve".html_safe
    end
  end

  def brand
    bar_name.brand.name if bar_name
  end

  def madel
    bar_name.name if bar_name
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
