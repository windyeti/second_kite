module KitesHelper
  def string_link(kite)
    "#{kite.kite_name.name} - #{kite.size}м&#178; - #{kite.price}&#8381;".html_safe
  end
end
