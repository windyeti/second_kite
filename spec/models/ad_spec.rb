require 'rails_helper'

RSpec.describe Ad, type: :model do
  it { should belong_to :user }
  it { should have_many(:ad_kites).dependent(:destroy) }
  it { should have_many(:kites).through(:ad_kites) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:total_price) }
end
