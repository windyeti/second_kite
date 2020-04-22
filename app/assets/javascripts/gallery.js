$(document).on('turbolinks:load', function() {
  document.querySelector('.gallery') && $('.gallery').on('click', function(e) {
    var target = e.target;
    if($(target).hasClass('photo__img')) {
      var src = target.dataset.origin;

      var $gallery = $(target).closest('.gallery');

      $gallery.find('.photo__container').removeClass('photo__container_active');
      $(target).parent().addClass('photo__container_active');

      $gallery.parent().find('.photo__big__container > img').remove();

      var $img = $('<img>').attr('src', src).addClass('photo__big__image');

      $img.on('load', function() {
        $gallery.parent().find('.photo__big__container .close').show()
      })

      $img.appendTo($gallery.parent().find('.photo__big__container'));

    }
  });
  $('.close').on('click', function(e) {
    var target = e.target
    $(target).parent().find('img').remove();
    $(target).hide();
    $(target).parent().parent().find('.gallery .photo__container').removeClass('photo__container_active');
  })
});
