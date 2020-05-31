class Board < ApplicationRecord
  belongs_to :user
  belongs_to :board_name

  has_many :ad_boards, dependent: :destroy
  has_many :ads, through: :ad_boards

  has_many_attached :best_photos
  has_many_attached :trouble_photos

  validates :length, :width, :year, :quality, :price, presence: true
  validates :length, :width, :year, :quality, :price, numericality: true

  validates :quality, inclusion: 1..5

  validate :type_photos

  # +++++++++++++++++++++++++++++++
  def self.custom_create(board_params, current_user)
    transaction do
      new_params = custom_params(board_params)
      board = current_user.boards.create( new_params )
      board
    end
  end

  def self.custom_params(board_params)
    board_name = BoardName.find_board_name(board_params)

    new_params = board_params
    new_params.delete(:brand)
    new_params.delete(:madel)
    new_params[:board_name] = board_name
    new_params
  end

  def custom_update(board_params)
    transaction do
      new_params = self.class.custom_params(board_params)
      update( new_params )
      self
    end
  end
  # +++++++++++++++++++++++++++++++

  # method for f.collection_check_boxes
  def board_name_name
    if board_name.approve
      "#{board_name.name} - #{length}x#{width}см - #{price}&#8381;".html_safe
    else
      "#{board_name.name} - #{length}x#{width}см - #{price}&#8381; need to approve".html_safe
    end
  end

  def brand
    board_name.brand.name if board_name
  end

  def madel
    board_name.name if board_name
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
