class Ad < ApplicationRecord
  belongs_to :user

  has_many :ad_kites, dependent: :destroy
  has_many :kites, through: :ad_kites

  has_many :ad_boards, dependent: :destroy
  has_many :boards, through: :ad_boards

  validates :title, :total_price, presence: true
end
