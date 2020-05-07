require 'rails_helper'

RSpec.describe Ad, type: :model do
  it { should belong_to :user }

  it { should have_many(:ad_kites).dependent(:destroy) }
  it { should have_many(:kites).through(:ad_kites) }

  it { should have_many(:ad_boards).dependent(:destroy) }
  it { should have_many(:boards).through(:ad_boards) }

  it { should have_many(:ad_bars).dependent(:destroy) }
  it { should have_many(:bars).through(:ad_bars) }

  it { should have_many(:ad_stuffs).dependent(:destroy) }
  it { should have_many(:stuffs).through(:ad_stuffs) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:total_price) }

  it { is_expected.to callback(:send_notification).after(:create) }

  describe 'call SendNotificationJob.perform_later' do
    let(:subject) { build(:ad, user: create(:user)) }
    it do
      expect(SendNotificationJob).to receive(:perform_later).with(subject)
      subject.save!
    end
  end
end
