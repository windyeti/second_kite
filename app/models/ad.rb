class Ad < ApplicationRecord
  belongs_to :user

  has_many :ad_kites, dependent: :destroy
  has_many :kites, through: :ad_kites

  has_many :ad_boards, dependent: :destroy
  has_many :boards, through: :ad_boards

  has_many :ad_bars, dependent: :destroy
  has_many :bars, through: :ad_bars

  has_many :ad_stuffs, dependent: :destroy
  has_many :stuffs, through: :ad_stuffs

  validates :title, :total_price, presence: true

  after_create :send_notification

  private

  def send_notification
    SendNotificationJob.perform_later(self)
  end
end
