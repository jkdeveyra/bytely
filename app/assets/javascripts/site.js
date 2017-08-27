// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function () {
  const clipboard = new Clipboard('#site .clipboard');
  var $shorten = $('.shorten')

  $shorten.tooltip({
    title: 'Copied',
    trigger: 'manual',
    placement: 'bottom'
  })

  clipboard.on('success', function(e) {
    $shorten.tooltip('show')
    setTimeout(function () {
      $shorten.tooltip('hide')
    }, 750)
  })
})
