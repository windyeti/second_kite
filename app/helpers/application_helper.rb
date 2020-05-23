module ApplicationHelper
  def flash_style(type)
    style = {
      alert: 'alert alert-info',
      notice: 'alert alert-success'
    }
    style[type.to_sym]
  end

  def thumbnail(photo)
    photo.variant(combine_options: { resize: '50x50^', gravity: 'center', extent: '50x50' }).processed
  end

  def big_photo(photo)
    photo.variant(resize: '1200x1200').processed
  end

  # def brand_kite_name
  #   result = {}
  #   Brand.order(:name).each do |b|
  #     arr = b.kite_names.map(&:name)
  #     result["#{b.name}"] = arr
  #   end
  #   result
  # end
end
