$(document).on('turbolinks:load', function() {
  $('.kite_name_form').on('ajax:success', function(e) {
    var data = e.detail[0].html;
    $('.kite-name__list').append(data);
    $('.kite-name__errors').children().remove();
    $(this).find('input[name="kite_name[name]"]').val('')
  })
    .on('ajax:error', function(e) {
      var data = e.detail[0].error;
      $('.kite-name__errors').html(data)
    })
})
