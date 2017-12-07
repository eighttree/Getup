import riot from 'riot'
import Vue from 'vue'
import feature from 'feature.js'
import 'whatwg-fetch'
import Promise from 'promise-polyfill'
import anime from 'animejs'
import mojs from 'mo-js'
import ScrollMagic from 'scrollmagic'
import slick from 'slick-carousel'
import p5 from 'p5'

import App from './app.vue'
import './app-tag.tag'

new Vue({
  el: '#app',
  render: h => h(App)
})

riot.mount('*')

;(function($){

$(() => {

  // アンカースクロールアニメーション
  const anchorScroll = () => {

    function scrollTo(selector, offset, cb) {
      console.log(selector)
      var body = [document.body, document.documentElement]
      var offset = offset || 0
      if(feature.touch){
        offset += 60
      }
      var el = document.querySelector(selector)
      var scrollAnim = anime({
        targets: body,
        scrollTop: el.offsetTop - offset,
        duration: 500,
        easing: 'easeInOutQuart',
        complete: function() { if (cb) cb(); }
      })
    }

    if(!feature.touch){
      $('a[href^="#"], .js-anchor-scroll').on('click', (e) => {
        e.preventDefault()
        var href = $(e.currentTarget).attr('href')
        scrollTo(href)
        return false
      })
    }
  }

  anchorScroll()
})

})(jQuery)

var s = function (sketch) {

  var x = 100
  var y = 100

  sketch.setup = function () {
    sketch.createCanvas(200, 200);
  }

  sketch.draw = function () {
    sketch.background(0)
    sketch.fill(255)
    sketch.rect(x, y, 50, 50)
  }
}

var myp5 = new p5(s);
console.log(`feature.touch = ${feature.touch}`)

// anime.js動作チェック
anime({
  targets: '.js-anime',
  translateX: 250,
  loop: true,
  direction: 'alternate',
  duration: 500,
  delay: 500
})

// mo.js動作チェック
const mojsAnime = new mojs.Html({
  el: '.js-anime-2',
  y: {0: 250},
  angleZ: {0: 360},
  duration: 500,
  easing: 'expo.out',
  repeat: true,
  isYoyo: true,
  delay: 500,
  onComplete() {
    this.replay()
  }
}).play()