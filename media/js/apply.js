$(document).ready(function($) {
    
    $('body').removeClass('no-js').addClass('js');
    
    //size what/buzz div
    $(window).bind('load resize', function() {
        var wh = $(window).height();
        $('#what').css({'height' : wh-82 });
        $('#buzz').css({'min-height' : wh-81 });
    });
    
    //nice easing
    $.extend($.easing, {
        easeOutExpo: function (x, t, b, c, d) {
            return (t === d) ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b;
        }
    });

    //scroll to content
    
    $('#primaryNav h1, a.continue').click(function() {
        var wh = $(window).height();
        $('body').scrollTo({top:(wh-81), left:'0px'}, 500, {easing: 'easeOutExpo'});
    });
    
    $('#primaryNav a').live('click', function() {
        $('html,body').scrollTo($(this).attr('href'), 500,
            {offset: -79, easing: 'easeOutExpo'});


        return false; 
    });

/*
    $('a.what').click(function() {
        $('body').scrollTo('#what', 500, {easing: 'easeOutExpo'});
    });
    
    $('a.how').click(function() {
        $('body').scrollTo('#how', 500, {offset: -79, easing: 'easeOutExpo'});
    });
    
    $('a.who').click(function() {
        $('body').scrollTo('#who', 500, {offset: -79, easing: 'easeOutExpo'});
    });
    
    $('a.when').click(function() {
        $('body').scrollTo('#when', 500, {offset: -79, easing: 'easeOutExpo'});
    });
    
    $('a.why').click(function() {
        $('body').scrollTo('#why', 500, {offset: -79, easing: 'easeOutExpo'});
    });
    
    $('a.buzz').click(function() {
        $('body').scrollTo('#buzz', 500, {offset: -79, easing: 'easeOutExpo'});
    });
*/

    // Sticky header on index page
    if ($('#page-index').length) {
        $scrollInterval = null;
        $(window).bind('resize scroll', function(e) {
            if ($scrollInterval === null) {
                $scrollInterval = true;

                $nav = $('#primaryNav');
                $spacer = $('#spacer');
                var wh = $(window).height();

                if ($(this).scrollTop() > wh-82 && $nav.css('position') != 'fixed') {
                    $nav.css({'position': 'fixed', 'top': '0px'});
                    $spacer.show();
                    $('body').addClass('white');

                } else if ($(this).scrollTop() < wh-82 && $nav.css('position') != 'relative') {
                    $nav.css({'position': 'relative', 'top': 'auto' });
                    $spacer.hide();
                    $('body').removeClass('white');
                }

                setInterval(function() {
                    $scrollInterval = null;
                }, 100);
            }
        });
    }
    
    //keyboard shortcuts
    $(document.documentElement).keyup(function (event) {
        if (event.keyCode == 71) {
            $('#grid').fadeToggle(100); // G toggles grid
        }
    });
    
});
