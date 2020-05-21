$(document).on('turbolinks:load', function() {
  $('.show-form-add-kite').on('click', function() {
    $('.form-add-kite').show();
    // $("input[type='submit']").on('click', function() {
    //   $(this).closest('.form-add-kite').hide();
    // })
  })
});
