"use strict";jQuery.easing.quart=function(x,t,b,c,d){return-c*((t=t/d-1)*t*t*t-1)+b},$(function(){$("a[href*=#]").click(function(){var $target,targetOffset;return location.pathname.replace(/^\//,"")===(void 0).pathname.replace(/^\//,"")&&location.hostname===(void 0).hostname&&($target=$((void 0).hash),$target=$target.length&&$target||$("[name="+(void 0).hash.slice(1)+"]"),$target.length)?(targetOffset=$target.offset().top,$("html,body").animate({scrollTop:targetOffset},200,"quart"),!1):void 0})});