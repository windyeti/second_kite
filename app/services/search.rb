class Services::Search
  def self.call(params_search)
    return if params_search[:query].empty?

    query = ThinkingSphinx::Query.escape(params_search[:query])

    case params_search[:scope]
    when 'All'
      result = Ad.search(query)
    when 'Kite'
      result = Ad.search conditions: {kite_name: query}
    when 'Board'
      result = Ad.search conditions: {board_name: query}
    when 'Bar'
      result = Ad.search conditions: {bar_name: query}
    when 'Stuff'
      result = Ad.search conditions: {stuff_name: query}
    else
      return
    end

    return if result.is_a? ThinkingSphinx::NoIndicesError
    result
  end
end
