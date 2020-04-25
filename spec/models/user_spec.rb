require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }

  it { should have_many(:kites).dependent :destroy }
  it { should have_many(:boards).dependent :destroy }
  it { should have_one(:account).dependent :destroy }

  it { is_expected.to callback(:create_account).after(:create) }

  describe 'create account after create user' do
    let!(:user) { create(:user) }

    it do
      expect(user.account).to eq Account.all.first
    end
  end
end
