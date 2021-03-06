class Brand < ApplicationRecord
  has_many :kite_names, dependent: :destroy
  has_many :board_names, dependent: :destroy
  has_many :bar_names, dependent: :destroy
  has_many :stuff_names, dependent: :destroy

  validates :name, presence: true

  # объект для autocomlete { brand: [madel1, madel2, ] }
  def self.brand_kite_name
    result = {}
    order(:name).where(approve: true).each do |b|
      arr = b.kite_names.map(&:name)
      result["#{b.name}"] = arr
    end
    result
  end

  def self.brand_board_name
    result = {}
    order(:name).where(approve: true).each do |b|
      arr = b.board_names.map(&:name)
      result["#{b.name}"] = arr
    end
    result
  end

  def self.brand_bar_name
    result = {}
    order(:name).where(approve: true).each do |b|
      arr = b.bar_names.map(&:name)
      result["#{b.name}"] = arr
    end
    result
  end

  def self.brand_stuff_name
    result = {}
    order(:name).where(approve: true).each do |b|
      arr = b.stuff_names.map(&:name)
      result["#{b.name}"] = arr
    end
    result
  end

  def self.custom_find_or_create_brand(params)
    brand_param = params[:brand].downcase
    brand = Brand.where( 'lower(name) = ?', brand_param ).first
    brand = Brand.create!(name: params[:brand]) if brand.nil?
    brand
  end
end
