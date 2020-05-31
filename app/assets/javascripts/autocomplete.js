function Autocomplete(brand, model) {
  this.brand = brand;
  this.model = model
}

Autocomplete.prototype.make = function() {
  var $brand_field = $(this.brand);
  var $brand_source = $brand_field.data('autocomplete-source');
  var $model_field = $(this.model);
  var $model_source = $model_field.data('autocomplete-source');

  $brand_field.autocomplete(
    {
      source: $brand_source
    }
  );
  $brand_field.on('change', function() {
    $model_field.val('');
    autocomplete_model()
  });
  // при редактировании (), если уже был выбран бренд,
  // то по нему должен быть автокомплит моделей
  if ( $brand_field.val().length ) {
    autocomplete_model()
  }

  function autocomplete_model() {

    var brand_field_value_lowercase = $brand_field.val().toLocaleLowerCase();
    var brand_property_str = '';

    for ( var property in $model_source ) {
      if(property.toLocaleLowerCase() === brand_field_value_lowercase ) {
        brand_property_str = property
      }
    }

    if ( brand_property_str ) {
      $model_field.autocomplete(
        {
          source: $model_source[brand_property_str]
        }
      )
    }
  }

}
