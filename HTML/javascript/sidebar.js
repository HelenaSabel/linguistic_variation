/*Código tirado de: https://github.com/bigspotteddog/ScrollToFixed*/


$(document).ready(function() {
    $('.header').scrollToFixed();
    
    /*

    $('.footer').scrollToFixed( {
        bottom: 0,
        limit: $('.footer').offset().top
    });*/

    $('#summary').scrollToFixed({
        marginTop: $('.header').outerHeight() + 10,
        limit: function() {
            var limit = $('.footer').offset().top - $('#summary').outerHeight(true) - 10;
            return limit;
        }/*,
        zIndex: 999*/});
});

