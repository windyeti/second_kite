$(document).on('turbolinks:load', function() {
  $('.stuff_name_form').on('ajax:success', function(e) {
    var data = e.detail[0].html;
    $('.stuff-name__list').append(data);
    $('.stuff-name__errors').children().remove();
    $(this).find('input[name="stuff_name[name]"]').val('')
  })
    .on('ajax:error', function(e) {
      var data = e.detail[0].error;
      $('.stuff-name__errors').html(data)
    })
})
