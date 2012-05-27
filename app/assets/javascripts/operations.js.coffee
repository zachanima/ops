jQuery ->
  $('li[data-sites]').hide()

  $('select#operation_site_id').change ->
    $('li[data-sites]').hide()
    $('li[data-sites~=' + $(@).val() + ']').show()
    $('li[data-sites]:not(:visible)').each ->
        $(@).find('input[type=number]').val('')

  $('select#operation_site_id').change()
