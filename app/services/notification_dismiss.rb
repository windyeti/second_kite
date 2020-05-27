class Services::NotificationDismiss
  include Rails.application.routes.url_helpers

  def call(args)
    links_dismiss = dismiss_brand_and_madel(args[:ad])
    args[:links_dismiss] = links_dismiss
    UserNotifyDismissMailer.send_message(args).deliver_later
  end

  def dismiss_brand_and_madel(ad)
    links_dismiss = ''
    ad.kites.each do |kite|
      links_dismiss << "<li>Brand: #{kite.kite_name.brand.name} (approve: #{kite.kite_name.brand.approve}), Model: #{kite.kite_name.name} (approve: #{kite.kite_name.approve}) <a href=#{url_for(kite)}>Link to equip</a></li>" unless kite.kite_name.approve
    end
    links_dismiss
  end
end
