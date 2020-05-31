$(document).on('turbolinks:load', function() {
  $('.board_name_form').on('ajax:success', function(e) {
    var data = e.detail[0].board_name;
    var approve = e.detail[0].approve;
    $('.board-name__list').append(JST['templates/board_name']({
      id: data.id,
      name: data.name,
      approve: approve
    }));
  $('.board-name__errors').children().remove();
  $(this).find('input[name="board_name[name]"]').val('')
  })
  .on('ajax:error', function(e) {
    var data = e.detail[0].errors;
    $('.board-name__errors').html(JST['templates/errors']({
      errors: data
    }))
  })
});
