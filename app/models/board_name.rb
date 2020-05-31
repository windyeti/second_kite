class BoardName < ApplicationRecord
  include Subscriptionable

  belongs_to :brand

  has_many :boards

  validates :name, presence: true

  before_save :check_brand_approve

  # '++++++++++++++++++++++++++++'
  def self.find_board_name(params)
    brand = Brand.custom_find_or_create_brand(params)
    custom_find_or_create_madel(brand, params)
  end

  def self.custom_find_or_create_madel(brand, params)
    madel_param = params[:madel].downcase
    madel = brand.board_names.where( 'lower(name) = ?', madel_param ).first
    madel = create!(brand_id: brand.id, name: params[:madel]) if madel.nil?
    madel
  end
  # '++++++++++++++++++++++++++++'

  private

  def check_brand_approve
    # запрувленая модель может быть создана только если запрувлен бренд
    # у незапрувленого бренда может быть создана незапрувленая модель
    if !brand.approve && approve
      errors.add('base', 'Brand must be approve first!!!')
      throw :abort
    end
  end
end
