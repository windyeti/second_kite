class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_one :account, dependent: :destroy

  has_many :ads, dependent: :destroy
  has_many :kites, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :bars, dependent: :destroy
  has_many :stuffs, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  after_create :create_account

  def admin?
    role === 'Admin'
  end

  def subscribable?(any_model_name)
    !any_model_name.subscriptions.find_by(user_id: self)
  end

  private

  def create_account
    build_account
    save
  end
end
