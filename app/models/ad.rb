class Ad < ApplicationRecord
  belongs_to :user

  has_many :ad_kites, dependent: :destroy
  has_many :kites, through: :ad_kites

  validates :title, :total_price, presence: true
end
