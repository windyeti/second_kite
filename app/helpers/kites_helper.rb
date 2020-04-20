module KitesHelper
  def string_link(kite)
    "#{kite.kite_name.name} - #{kite.size}m2 - #{kite.price}<span class='product__rub text-muted'>&#8381;</span>".html_safe
  end
end
