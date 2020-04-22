module KitesHelper
  def string_link(kite)
    "#{kite.kite_name.name} - #{kite.size}м&#178; - #{kite.price}&#8381;".html_safe
  end

  def string_full_link(kite)
    price = kite.singly_sale ? ", <span class='text-muted'>Price: </span>#{kite.price}&#8381;" : ''
    "<strong>#{kite.kite_name.brand.name}, #{kite.kite_name.name},</strong> <span class='text-muted'>Size: </span> #{kite.size}м&#178;, <span class='text-muted'>Year: </span>#{kite.year}, <span class='text-muted'>Quality:</span>#{kite.quality}#{price}".html_safe
  end
end
