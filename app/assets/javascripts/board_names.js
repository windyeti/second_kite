$(document).on('turbolinks:load', function() {
  $('.board_name_form').on('ajax:success', function(e) {
  var data = e.detail[0].html;
  $('.board-name__list').append(data);
  $('.board-name__errors').children().remove();
  $(this).find('input[name="board_name[name]"]').val('')
  })
  .on('ajax:error', function(e) {
    var data = e.detail[0].error;
  $('.board-name__errors').html(data)
  })
});
