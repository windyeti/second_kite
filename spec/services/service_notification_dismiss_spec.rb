require 'rails_helper'

RSpec.describe Services::NotificationDismiss, type: :service do
  let!(:args) { { ad: create(:ad, user: create(:user, email: 'user@mail.com')),
                        subject: 'Text subject',
                        message: 'Text text text'
  } }
  it 'call mailer UserNotifyDismissMailer' do
    expect(UserNotifyDismissMailer).to receive(:send_message).with(args).and_call_original
    Services::NotificationDismiss.new.call(args)
  end
end
