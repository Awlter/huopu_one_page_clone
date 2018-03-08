(function worker() {
  $.ajax({
    url: '/statistics', 
    success: function(data) {

    },
    complete: function() {
      setTimeout(worker, 500);
    }
  });
})();