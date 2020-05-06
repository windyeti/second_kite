module ApplicationHelper
  def flash_style(type)
    style = {
      alert: 'alert alert-info',
      notice: 'alert alert-success'
    }
    style[type.to_sym]
  end

  def thumbnail(photo)
    photo.variant(combine_options: { resize: '50x50^', gravity: 'center', extent: '50x50' }).processed
  end

  def big_photo(photo)
    photo.variant(resize: '1200x1200').processed
  end

  def subscribable?(any_model_name)
    !any_model_name.subscriptions.find_by(user_id: current_user)
    # sub = current_user.subscriptions.select { |s| s.subscriptionable == any_model_name }
    # sub.length <= 0
  end
end

# TODO .service_url
