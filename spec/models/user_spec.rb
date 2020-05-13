require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }

  it { should have_one(:account).dependent :destroy }
  it { should have_many(:kites).dependent :destroy }
  it { should have_many(:boards).dependent :destroy }
  it { should have_many(:bars).dependent :destroy }
  it { should have_many(:stuffs).dependent :destroy }
  it { should have_many(:subscriptions).dependent :destroy }

  it { should have_one(:account).dependent :destroy }

  it { is_expected.to callback(:create_account).after(:create) }

  describe 'create account after create user' do
    let!(:user) { create(:user) }

    it do
      expect(user.account).to eq Account.all.first
    end
  end

  describe 'user can not subscribe two time to one resource' do
    before { sign_in(subject) }
    let!(:kite_name_1) { create(:kite_name) }
    let!(:kite_name_2) { create(:kite_name) }
    let!(:subscription) { create(:subscription, subscriptionable: kite_name_1, user: subject) }

    it 'can not subscribe' do
      expect(subject.subscribable?(kite_name_1)).to be_falsey
    end

    it 'can subscribe' do
      expect(subject.subscribable?(kite_name_2)).to be_truthy
    end
  end
end
