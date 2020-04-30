module StuffsHelper
  def stuff_string_link(stuff)
    "#{stuff.stuff_name.name} - #{truncate(stuff.description, length: 15)} - #{stuff.price}&#8381;".html_safe
  end

  def stuff_string_full_link(stuff)
    price = stuff.singly_sale ? ", <span class='text-muted'>Price: </span>#{stuff.price}&#8381;" : ''
    "<strong>#{stuff.stuff_name.brand.name}, #{stuff.stuff_name.name},</strong>
    <span class='text-muted'>Size: </span> #{stuff.size}м&#178;,
    <span class='text-muted'>Year: </span>#{stuff.year},
    <span class='text-muted'>Quality:</span>#{stuff.quality}#{price}
    <p>#{kite.description}</p>".html_safe
  end
end


