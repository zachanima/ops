jQuery ->
  $('li[data-sites]').hide()

  $('select#operation_site_id').change ->
    $('li[data-sites]').hide()
    $('li[data-sites~=' + $(@).val() + ']').show()
    $('li[data-sites]:not(:visible)').each ->
        $(@).find('input[type=number]').val('')

  $('select#operation_site_id').change()

  $('td.hauled input[type=checkbox]').change ->
    value = $(@).parents('td').siblings('td.value')
    hauling = $('span[data-hauling]').data('hauling') / $('td.hauled :checked').length
    $('td.value').each ->
      if $(@).is(':checked')
        $(@).html($(@).data('total') + hauling)
      else
        value.html value.data('total')
    
