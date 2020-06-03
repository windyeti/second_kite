require 'rails_helper'

RSpec.describe DismissUserBrandJob, type: :job do
  let!(:args) { { ad: create(:ad, user: create(:user, email: 'user@mail.com')),
                        subject: 'Text subject',
                        message: 'Text text text'
                    } }
  let(:service_instance) { double(Services::NotificationDismiss) }

  before do
    allow(Services::NotificationDismiss).to receive(:new).and_return(service_instance)
  end
  it 'call service Services::NotificationDismiss' do
    expect(service_instance).to receive(:call).with(args)
    DismissUserBrandJob.perform_now(args)
  end
end
