// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).on('turbolinks:load', function () {
  if ($('#site').length > 0) {
    const $shorten = $('.shorten')
    const $linkContainer = $('.link-container')
    const $clipboard = $('#site .clipboard')
    const $statLink = $('#site a.stat')

    $shorten.tooltip({
      title: 'Copied',
      trigger: 'manual',
      placement: 'bottom'
    })

    const clipboard = new Clipboard('#site .clipboard');
    clipboard.on('success', function(e) {
      $shorten.tooltip('show')
      setTimeout(function () {
        $shorten.tooltip('hide')
      }, 750)
    })

    $('#shorten-form').submit(function(e) {
      const formElem = this
      e.preventDefault()

      const data = $(this).serialize()

      $.post({
        url: '/links.json',
        data: data,
        success: function (data) {
          $linkContainer.find('.original').html(data.original_url)
          $shorten.html($shorten.data('prepend') + data.code)
          $clipboard[0].dataset.clipboardText = data.shorten_url
          $statLink.prop('href', $statLink.data('prepend') + data.id)
          $linkContainer.removeClass('hidden')
          formElem.reset()
        },
        error: function () {
        }
      })
    })
  }
})
