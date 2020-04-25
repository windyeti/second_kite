module BoardsHelper
  def board_string_link(board)
    "#{board.board_name.name} - #{board.length}x#{board.width}см - #{board.price}&#8381;".html_safe
  end

  def board_string_full_link(board)
    price = board.singly_sale ? ", <span class='text-muted'>Price: </span>#{board.price}&#8381;" : ''
    "<strong>#{board.board_name.brand.name}, #{board.board_name.name},</strong> <span class='text-muted'>Size: </span> #{board.length}x#{board.width}см, <span class='text-muted'>Year: </span>#{board.year}, <span class='text-muted'>Quality:</span>#{board.quality}#{price}".html_safe
  end
end
