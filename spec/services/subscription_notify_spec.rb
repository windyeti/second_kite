require 'rails_helper'

RSpec.describe Services::NotificationEquipment, type: :service do
  let!(:kite_name) { create(:kite_name) }
  let!(:subscription) { create(:subscription, user: create(:user, email: 'mail_2@mail.com'), subscriptionable: kite_name) }
  let!(:kite) { create(:kite, user: create(:user, email: 'mail@mail.com'), kite_name: kite_name) }
  let!(:ad) { create(:ad, user: create(:user), kite_ids: [kite.id]) }


  it 'calls notify in SubscriptionMailer' do
    expect(SubscriptionMailer).to receive(:notify).with(subscription).and_call_original
    subject.call(ad)
  end
end
