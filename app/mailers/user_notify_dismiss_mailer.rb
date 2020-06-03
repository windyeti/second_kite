include ActionView::Helpers
include ActionDispatch::Routing
include Rails.application.routes.url_helpers

class UserNotifyDismissMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notify_dismiss_mailer.send_message.subject
  #
  def send_message(args)
    @email = args[:ad].user.email
    @links_dismiss = args[:links_dismiss]
    @link_ad = url_for(args[:ad])
    @message = args[:message]

    mail to: @email, subject: args[:subject]
  end
end
