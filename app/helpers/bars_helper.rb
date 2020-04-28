module BarsHelper
  def bar_string_link(bar)
    "#{bar.bar_name.name} - #{bar.length}см - #{bar.price}&#8381;".html_safe
  end

  def bar_string_full_link(bar)
    price = bar.singly_sale ? ", <span class='text-muted'>Price: </span>#{bar.price}&#8381;" : ''
    "<strong>#{bar.bar_name.brand.name}, #{bar.bar_name.name},</strong> <span class='text-muted'>Size: </span> #{bar.length}x#{bar.width}см, <span class='text-muted'>Year: </span>#{bar.year}, <span class='text-muted'>Quality:</span>#{bar.quality}#{price}".html_safe
  end
end
