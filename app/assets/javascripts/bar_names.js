$(document).on('turbolinks:load', function() {
  $('.bar_name_form').on('ajax:success', function(e) {
    var data = e.detail[0].html;
    $('.bar-name__list').append(data);
    $('.bar-name__errors').children().remove();
    $(this).find('input[name="board_name[name]"]').val('')
  })
    .on('ajax:error', function(e) {
      var data = e.detail[0].error;
      $('.bar-name__errors').html(data)
    })
});
