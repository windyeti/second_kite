class KiteName < ApplicationRecord
  include Subscriptionable

  belongs_to :brand

  has_many :kites

  validates :name, presence: true

  def self.custom_find_or_create_kite_name(brand, params)
    kite_name_param = params[:kite_name].downcase
    kite_name = brand.kite_names.where( 'lower(name) = ?', kite_name_param ).first
    kite_name = KiteName.create!(brand_id: brand.id, name: params[:kite_name]) if kite_name.nil?
    kite_name
  end
end
