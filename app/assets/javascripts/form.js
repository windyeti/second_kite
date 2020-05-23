function Form(form) {
  this.form = form
}

Form.prototype.render = function() {

//render form

  var $containerForm = $('<div>').addClass('container-form-add col-10 col-md-8').css({top: 20 + $(window).scrollTop()});
  $containerForm.appendTo('body');
  $containerForm.html(this.form);


//button close form

  $('.close_form').on('click', function() {
    $(this).closest('.container-form-add').remove();
  })
}
