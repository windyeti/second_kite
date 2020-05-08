require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'Admin' do
    let(:user) { create(:user, role: 'Admin') }

    it { should be_able_to(:manage, :all) }
  end

  describe 'Guest' do
    let(:user) { nil }

    %w[Kite Board Bar Stuff].each do |equipment|
      it { should be_able_to :show, equipment.constantize }
    end

    %i[read kites boards bars stuffs].each do |action|
      it { should be_able_to action, Ad }
    end
  end

  describe 'Authenticated user' do
    let(:user) { create(:user, email: 'userr@mail.com') }
    let(:other_user) { create(:user, email: 'other@mail.com') }

    %i[ad kite board bar stuff].each do |resource|
      it { should be_able_to :create, resource.to_s.classify.constantize }

      %i[update destroy].each do |action|
        it { should be_able_to action, create(resource, user: user) }
      end
    end

    %i[update show].each do |action|
      it { should be_able_to action, create(:account, user: user) }
    end

    it { should be_able_to :read, Brand }

    it { should be_able_to :destroy, ActiveStorage::Attachment }

    it { should be_able_to :create, create(:subscription, subscriptionable: create(:kite_name)) }
    it { should be_able_to :destroy, create(:subscription, subscriptionable: create(:kite_name), user: user) }

  end
end
