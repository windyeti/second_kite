ThinkingSphinx::Index.define :ad, with: :active_record do
  indexes title, sortable: true
  indexes description

  indexes kites.kite_name.name, as: :kite_name
  indexes kites.kite_name.brand.name, as: :kite_name_brand
  indexes kites.size, as: :kite_size
  indexes kites.year, as: :kite_year

  indexes boards.board_name.name, as: :board_name
  indexes boards.board_name.brand.name, as: :board_name_brand
  indexes boards.width, as: :board_width
  indexes boards.length, as: :board_length
  indexes boards.year, as: :board_year

  indexes bars.bar_name.name, as: :bar_name
  indexes bars.bar_name.brand.name, as: :bar_name_brand
  indexes bars.length, as: :bar_length
  indexes bars.year, as: :bar_year

  indexes stuffs.stuff_name.name, as: :stuff_name
  indexes stuffs.stuff_name.brand.name, as: :stuff_name_brand
  indexes stuffs.description, as: :stuff_description
end
