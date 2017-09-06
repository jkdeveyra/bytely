// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function () {
  if ($('#site').length > 0) {
    const $shortened = $('.shortened')
    const $linkContainer = $('.link-container')
    const $errorContainer = $('.error-container')
    const $clipboard = $('#site .clipboard')
    const $statLink = $('#site a.stat')

    $shortened.tooltip({
      title: 'Copied',
      trigger: 'manual',
      placement: 'bottom'
    })

    const clipboard = new Clipboard('#site .clipboard');
    clipboard.on('success', function(e) {
      $shortened.tooltip('show')
      setTimeout(function () {
        $shortened.tooltip('hide')
      }, 750)
    })

    $('#shortened-form').submit(function(e) {
      const formElem = this
      e.preventDefault()

      const data = $(this).serialize()

      $.post({
        url: '/links.json',
        data: data,
        success: function (data) {
          $linkContainer.find('.original').html(data.original_url)
          $shortened.html($shortened.data('prepend') + data.code)
          $clipboard[0].dataset.clipboardText = data.shortened_url
          $statLink.prop('href', $statLink.data('prepend') + data.id)
          $linkContainer.removeClass('hidden')
          $errorContainer.addClass('hidden')
          formElem.reset()
        },
        error: function (data) {
          const message = data.responseJSON.message || 'Error URL provided'
          $errorContainer.html(message)
          $linkContainer.addClass('hidden')
          $errorContainer.removeClass('hidden')
        }
      })
    })
  }
})
