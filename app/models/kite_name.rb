class KiteName < ApplicationRecord
  include Subscriptionable

  belongs_to :brand

  has_many :kites

  validates :name, presence: true

  def self.find_kite_name(params)
    brand = Brand.custom_find_or_create_brand(params)
    custom_find_or_create(brand, params)
  end

  def self.custom_find_or_create(brand, params)
    madel_param = params[:madel].downcase
    madel = brand.kite_names.where( 'lower(name) = ?', madel_param ).first
    madel = create!(brand_id: brand.id, name: params[:madel]) if madel.nil?
    madel
  end
end
