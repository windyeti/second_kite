$(document).on('turbolinks:load', function() {
  $('.stuff_name_form').on('ajax:success', function(e) {
    var data = e.detail[0].stuff_name;
    var approve = e.detail[0].approve;
    $('.stuff-name__list').append(JST['templates/stuff_name']({
      id: data.id,
      name: data.name,
      approve: approve
    }));
    $('.stuff-name__errors').children().remove();
    $(this).find('input[name="stuff_name[name]"]').val('')
  })
    .on('ajax:error', function(e) {
      var data = e.detail[0].errors;
      $('.stuff-name__errors').html(JST['templates/errors']({
        errors: data
      }))
    })
})
