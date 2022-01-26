	$(document).ready(function(){
	    $(".notification").each(function(){
	        $(this).css('top', 65 * $(this).index() + 'px');
	        $('.notification').animate({ 'margin-left': '0%' });
	        $('.notification').delay(30000).fadeOut();
	    });
        
	    $(".notification").click(function myfunction() {
	      
	        //$('document').scrollTo("#famitoit");
	        $('.notification').delay(500).hide();
	        $("html, body").delay(300).animate({
	            scrollTop: $('#features').offset().top}, 500);
	       
	    });

	});
