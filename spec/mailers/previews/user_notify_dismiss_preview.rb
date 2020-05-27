# Preview all emails at http://localhost:3000/rails/mailers/user_notify_dismiss
class UserNotifyDismissPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_notify_dismiss/send_message
  def send_message
    UserNotifyDismissMailer.send_message
  end

end
