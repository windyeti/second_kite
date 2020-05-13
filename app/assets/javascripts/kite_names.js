$(document).on('turbolinks:load', function() {
  $('.kite_name_form').on('ajax:success', function(e) {
    var data = e.detail[0].kite_name;
    $('.kite-name__list').append(JST['templates/kite_name']({
      id: data.id,
      name: data.name
    }));
    $('.kite-name__errors').children().remove();
    $(this).find('input[name="kite_name[name]"]').val('')
  })
    .on('ajax:error', function(e) {
      var data = e.detail[0].errors;
      $('.kite-name__errors').html(JST['templates/errors']({
        errors: data
      }))
    })
})
