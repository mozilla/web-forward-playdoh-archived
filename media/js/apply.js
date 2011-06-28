/*
 * JavaScript Pretty Date
 * Copyright (c) 2008 John Resig (jquery.com)
 * Licensed under the MIT license.
 */

// load the buzz feed
function updateBuzz() {
    // take a javascript time and convert it into a relative time
    function toRelDate(date) {
        // credit?  John Resig of course: http://ejohn.org/blog/javascript-pretty-date/
        var diff = (((new Date()).getTime() - new Date(date).getTime()) / 1000),
        day_diff = day_diff = Math.floor(diff / 86400);

	      var txtDiff = day_diff == 0 && (
			      diff < 60 && "just now" ||
			          diff < 120 && "1 minute ago" ||
			          diff < 3600 && Math.floor( diff / 60 ) + " minutes ago" ||
			          diff < 7200 && "1 hour ago" ||
			          diff < 86400 && Math.floor( diff / 3600 ) + " hours ago") ||
		        day_diff == 1 && "Yesterday" ||
		        day_diff < 7 && day_diff + " days ago" ||
		        day_diff < 31 && Math.ceil( day_diff / 7 ) + " weeks ago" ||
		        Math.ceil( day_diff / 30 ) + " months ago";

        return $("<div>").text(txtDiff).addClass("posted");
    }

    $.get('/media/latest.json', function(feed) {
        function createEntry(obj) {
            var n = $("<li>"), c = n;
            c.text(obj.title);
            if (obj.link && obj.link.length) {
                c = $("<a>").attr('href', obj.link).appendTo(n);
            }
            if (obj.posted) c.append(toRelDate(obj.posted));
            if (obj.when) c.append($("<div>").text(obj.when).addClass("date"));
            return n;
        }

        for (var i = 0; i < feed.tweets.length; i++) {
            $("#tweets").append(createEntry(feed.tweets[i]));
        }
        for (var i = 0; i < feed.posts.length; i++) {
            $("#blog").append(createEntry(feed.posts[i]));
        }
        for (var i = 0; i < feed.events.length; i++) {
            $("#events").append(createEntry(feed.events[i]));
        }
    }, "json");
}

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
    
    //fancy box
    $("#movie").fancybox({
        padding       : 0,
        overlayShow   : false,
        autoScale     : false,
        transitionIn  : 'fade',
        transitionOut : 'fade',
        title         : this.title,
        width         : 640,
        height        : 388,
        href          : this.href,
        type          : 'inline',
        onComplete    : function() {
            $(this.href).parent('div').css({
                height: '360px',
                overflow: 'hidden'
            })
        }
    }); 

    //scroll to content
    
    $('#primaryNav img, a.continue').click(function() {
        var wh = $(window).height();
        $('body').scrollTo({top:(wh-81), left:'0px'}, 500, {easing: 'easeOutExpo'});
    });

    $('#primaryNav a').live('click', function() {
        $('html,body').scrollTo($(this).attr('href'), 500,
            {offset: -79, easing: 'easeOutExpo'});

        return false; 
    });

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
    
    // now load the buzz feed, which has a much less aggressive caching
    // to give you that realtime feel, hence stored in a separate dynamically
    // updated json file.
    updateBuzz();
    
});
