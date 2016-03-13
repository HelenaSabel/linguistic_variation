/*Código tirado de: http://codepen.io/yeony/pen/CFhbu*/


(function($) {
  $(document).ready(function() {
    $('#move').scrollToFixed({
        marginTop: 8,
        limit: function() {
            var limit = $('#footer').offset().top - $('#move').outerHeight(true) - 10;
            return limit;
        }
    });
    
    /*$("#nav").scrollToFixed({
        marginTop: $('#header').outerHeight() + 10,
      limit:  function() {
          var limit = $('#footer').offset().top - $('#nav').outerHeight(true) - 10;
          return limit;
      },
        zIndex: 999,
        preFixed: function() { $(this).find('.title').css('color', 'blue'); },
        preAbsolute: function() { $(this).find('.title').css('color', 'red'); },
        postFixed: function() { $(this).find('.title').css('color', ''); },
        postAbsolute: function() { $(this).find('.title').css('color', ''); }
    });*/
  });
} (jQuery));