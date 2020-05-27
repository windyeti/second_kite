$(document).on('turbolinks:load', function() {
  $('.proof').on('ajax:success', function(e) {
    var proof = e.detail[0].proof;

    var selector = '.' + proof.klass + '_id_' + proof.proof.id;

// proof.proof.name -- для брендов и моделей; proof.proof.title -- для заголовка объявления
      $(selector).html(JST['templates/proof']({
      name: proof.proof.name || proof.proof.title
    }));

// если запрувили Бренд, то надо сделать видимыми ссылки на модели, которые надо прувить
      if (proof.klass === 'Brand') {
        $('.items_Brand_' + proof.proof.name + ' .link-for-brand_' + proof.proof.name).toggleClass('proof-hidden-link')
      }

    $('.errors').children().remove();
  })
    .on('ajax:error', function(e) {
      var data = e.detail[0].errors;
      $('.errors').html(JST['templates/errors']({
        errors: data
      }))
    })
})
