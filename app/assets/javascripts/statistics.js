(function worker() {
  $.ajax({
    url: '/statistics',
    dataType: 'script',
    complete: function() {
      setTimeout(worker, 1000);
    }
  });
})();