require 'rails_helper'

RSpec.describe SendNotificationJob, type: :job do
  let!(:ad) { create(:ad, user: create(:user)) }
  let(:service) { double(Services::NotificationEquipment) }

  before do
    allow(Services::NotificationEquipment).to receive(:new).and_return(service)
  end
  it 'calls call in Services::NotificationEquipment' do
    expect(service).to receive(:call).with(ad)
    subject.perform(ad)
  end
end
