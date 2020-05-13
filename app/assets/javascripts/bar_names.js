$(document).on('turbolinks:load', function() {
  $('.bar_name_form').on('ajax:success', function(e) {
    var data = e.detail[0].bar_name;
    $('.bar-name__list').append(JST['templates/bar_name']({
      id: data.id,
      name: data.name
    }));
    $('.bar-name__errors').children().remove();
    $(this).find('input[name="bar_name[name]"]').val('')
  })
    .on('ajax:error', function(e) {
      var data = e.detail[0].errors;
      $('.bar-name__errors').html(JST['templates/errors']({
        errors: data
      }))
    })
});
