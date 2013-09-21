jQuery ->
  $('#user_postal_code').autocomplete
    source: $('#user_postal_code').data('autocomplete-source')