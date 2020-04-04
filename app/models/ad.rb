class Ad < ApplicationRecord
  belongs_to :user

  validates :title, :total_price, presence: true
end
