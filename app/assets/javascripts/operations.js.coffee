jQuery ->
  $('li[data-sites]').hide()

  $('select#operation_site_id').change ->
    $('li[data-sites]').hide()
    $('li[data-sites~=' + $(@).val() + ']').show()
