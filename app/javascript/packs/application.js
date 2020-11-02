require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')

$(document).ready(function() {

	///////////////// fixed menu on scroll for desctop
    if ($(window).width() > 680) {

        var navbar_height =  $('.menu').outerHeight();

        $(window).scroll(function(){
            if ($(this).scrollTop() > 0) {
				 $('.menu').css('height', navbar_height + 'px');
                 $('#menu').addClass("fixed-top");

            }else{
                $('#menu').removeClass("fixed-top");
                $('.menu').css('height', 'auto');
            }
        });
    } // end if
    setTimeout(function() {
    $('.flash').fadeOut('fast');
}, 3000);

});
