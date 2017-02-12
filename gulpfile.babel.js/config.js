module.exports = {
  /* 特別な定義が不要なタスクの設定 */
  appPath: 'app/',

  iconfont: {
    sketch: 'symbol-font-14px.sketch',
  },

  copy: {
    js: [
      'node_modules/jquery/dist/jquery.min.*',
    ],
    css: [
      'node_modules/sanitize.css/sanitize.css',
      'node_modules/slick-carousel/slick/slick.css',
      'node_modules/slick-carousel/slick/slick-theme.css',
    ],
  },

  concat: {
    js: [
      'js/plugins-base.js',
      'node_modules/animejs/anime.js',
      'node_modules/slick-carousel/slick/slick.min.js',
      'node_modules/scrollmagic/scrollmagic/minified/ScrollMagic.min.js',
      'node_modules/scrollmagic/scrollmagic/minified/plugins/debug.addIndicators.min.js',
    ]
  },

  css : {
    file: [
      'css/main.css'
    ]
  }

};
