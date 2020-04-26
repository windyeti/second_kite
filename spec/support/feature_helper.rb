module FeatureHelper
  def board_string_link(board)
    "#{board.board_name.name} - #{board.length}x#{board.width}см - #{board.price}&#8381;".html_safe
  end
end
