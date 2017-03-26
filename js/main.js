(function($){

// Easingの追加
jQuery.easing.quart = (x, t, b, c, d) => {
  return -c * ((t = t / d - 1) * t * t * t - 1) + b;
};

$(() => {

  // スマホ判定
  var _ua = (function(u){
    return {
      Tablet:(u.indexOf('windows') != -1 && u.indexOf('touch') != -1)
        || u.indexOf('ipad') != -1
        || (u.indexOf('android') != -1 && u.indexOf('mobile') == -1)
        || (u.indexOf('firefox') != -1 && u.indexOf('tablet') != -1)
        || u.indexOf('kindle') != -1
        || u.indexOf('silk') != -1
        || u.indexOf('playbook') != -1,
      Mobile:(u.indexOf('windows') != -1 && u.indexOf('phone') != -1)
        || u.indexOf('iphone') != -1
        || u.indexOf('ipod') != -1
        || (u.indexOf('android') != -1 && u.indexOf('mobile') != -1)
        || (u.indexOf('firefox') != -1 && u.indexOf('mobile') != -1)
        || u.indexOf('blackberry') != -1
    }
  })(window.navigator.userAgent.toLowerCase());

  // アンカースクロールアニメーション
  if(!_ua.Mobile || !_ua.Tablet){
    $('a[href*="#"]').click(function() {
      var href = $(this).attr('href');
      var $target = $(href === '#' || href === '' ? 'html' : href);
      TweenMax.to(window, 1, {scrollTo:$target.offset().top});
      return false;
    });
  }

});

})(jQuery);
