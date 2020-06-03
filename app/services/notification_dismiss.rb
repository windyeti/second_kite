class Services::NotificationDismiss
  include Rails.application.routes.url_helpers

  def call(args)
    links_dismiss = dismiss_brand_and_madel(args[:ad])
    args[:links_dismiss] = links_dismiss
    UserNotifyDismissMailer.send_message(args).deliver_later
  end

  private

  def dismiss_brand_and_madel(ad)
    links_dismiss = ''
    ad.kites.each do |kite|
      links_dismiss << "<li>Brand: #{kite.kite_name.brand.name} (approve: #{kite.kite_name.brand.approve}), Model: #{kite.kite_name.name} (approve: #{kite.kite_name.approve}) <a href=#{url_for(kite)}>Link to equip</a></li>" unless kite.kite_name.approve
    end
    ad.boards.each do |board|
      links_dismiss << "<li>Brand: #{board.board_name.brand.name} (approve: #{board.board_name.brand.approve}), Model: #{board.board_name.name} (approve: #{board.board_name.approve}) <a href=#{url_for(board)}>Link to equip</a></li>" unless board.board_name.approve
    end
    ad.bars.each do |bar|
      links_dismiss << "<li>Brand: #{bar.bar_name.brand.name} (approve: #{bar.bar_name.brand.approve}), Model: #{bar.bar_name.name} (approve: #{bar.bar_name.approve}) <a href=#{url_for(bar)}>Link to equip</a></li>" unless bar.bar_name.approve
    end
    ad.stuffs.each do |stuff|
      links_dismiss << "<li>Brand: #{stuff.stuff_name.brand.name} (approve: #{stuff.stuff_name.brand.approve}), Model: #{stuff.stuff_name.name} (approve: #{stuff.stuff_name.approve}) <a href=#{url_for(stuff)}>Link to equip</a></li>" unless stuff.stuff_name.approve
    end
    links_dismiss
  end
end
