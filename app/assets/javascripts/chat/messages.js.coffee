$ ->
  $('form.js-fileupload').each ->
    $(this).fileupload
      dataType: 'script'
      dropZone: $(this).find('.js-dropfile')
      add: (e, data) ->
        $(this).addClass('js-uploading')
        $(this).fadeTo('fast', 0.5)
        data.submit()
      done: (e, data) ->
        $(this).fadeTo('fast', 1.0)

  $('body').on 'keydown', '.js-submit-by-hotkey', (e) ->
    if e.ctrlKey and e.keyCode is 13
      e.preventDefault()
      $(this).closest('form').submit()
      false
    true