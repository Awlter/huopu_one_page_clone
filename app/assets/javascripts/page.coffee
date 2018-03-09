# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $footer = $('footer')
  $postInfo = $('.post-info')
  $poster = $('header')

  footerHeight = $footer.height()
  postInfoHeight = $postInfo.outerHeight()
  posterHeight = $poster.height()

  $postInfo.css({'position': 'fixed', 'bottom': footerHeight, margin: 0 })

  $(window).scroll (event) =>
    windowPosition = $(this).scrollTop()
    if windowPosition == 0
      $postInfo.css({'position': 'fixed', 'bottom': footerHeight, margin: 0 })
    else if windowPosition <= postInfoHeight
      $postInfo.css(bottom: footerHeight - windowPosition)
    else if windowPosition > postInfoHeight
      $postInfo.css({'position': 'relative', 'bottom': 0, 'margin-bottom': '10px'})
