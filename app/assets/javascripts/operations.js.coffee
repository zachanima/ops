isk = (value) ->
  value += ''
  x = value.split('.')
  x1 = x[0]
  if x.length > 1
    x2 = '.' + x[1].substring(0, 2)
  else
    x2 = '.00'

  regex = /(\d+)(\d{3})/

  while regex.test(x1)
    x1 = x1.replace(regex, '$1' + ',' + '$2')

  x1 + x2 + ' ISK'



jQuery ->
  # Hide all items on operation form
  $('li[data-sites]').hide()

  # Update list of items on operation form
  $('select#operation_site_id').change ->
    $('li[data-sites]').hide()
    $('li[data-sites~=' + $(@).val() + ']').show()
    $('li[data-sites]:not(:visible)').each ->
        $(@).find('input[type=number]').val('')

  # Trigger change event on operation form
  $('select#operation_site_id').change()

  
  $('td.hauled input[type=checkbox]').change ->
    hauling = $('span[data-hauling]').data('hauling') / $('td.hauled :checked').length
    $('td.value').each ->
      value = $(@).parents('td').siblings('td.value')
      checkbox = $(@).siblings('td.hauled').children('input[type=checkbox]')
      if checkbox.is(':checked')
        $(@).html(isk($(@).data('total') + hauling))
      else
        $(@).html(isk($(@).data('total')))
