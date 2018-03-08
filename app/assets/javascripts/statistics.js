var signal = function() {
  $.ajax({
    url: '/statistics',
    dataType: 'script'
  })
}

jQuery(function($) {
  setInterval(signal, 1000)
});