module.exports = (grunt) ->

  # ライセンスコメントを残した圧縮
  # http://qiita.com/shinnn/items/57327006390f2181f550
  licenseRegexp = /^\!|^@preserve|^@cc_on|\bMIT\b|\bMPL\b|\bGPL\b|\(c\)|License|Copyright/mi

  isLicenseComment = do ->
    _prevCommentLine = 0

    (node, comment) ->
      if licenseRegexp.test(comment.value) or
      comment.line is 1 or
      comment.line is _prevCommentLine + 1

        _prevCommentLine = comment.line
        return true

      _prevCommentLine = 0
      false

  grunt.initConfig
    compass:
      dev:
        options:
          config: "config.rb"
      pro:
        options:
          config: "config.rb"
          environment: "production"
          # スプライトが重くなるのでコメントアウト
          # force: true
    coffee:
      compile:
        expand: true
        flatten: true
        src: ["coffee/*.coffee"]
        dest: "public/js/"
        ext: ".js"
        options:
          bare: true
    autoprefixer:
      single_file:
        # src: "css-dev/main.css"
        # dest: "css/main.css"
        src: "public/css/main.css"
    uglify:
      options:
        mangle: false
        preserveComments: isLicenseComment
      compress_target:
        files:
          "public/js/main.js": "public/js/main.js"
          "public/js/vendor/modernizr.min.js": "bower_components/modernizr/modernizr.js"
    watch:
      compass:
        files: ["scss/*.scss"]
        tasks: [
          "compass:dev"
          "autoprefixer"
          # "kss"
        ]
      coffee:
        files: ["coffee/*.coffee"]
        tasks: "coffee"
      # js:
      #   files: ["js/*.js"]
      #   tasks: "uglify"
    webfont:
      icon:
        src: "public/fonts/svg/*.svg"
        dest: "public/fonts/"
        destCss: "scss/"
        options:
          font: "my-icon"
          stylesheet: "scss"
          htmlDemo: true
          syntax: "bem"
          relativeFontPath: "../fonts/"
          templateOptions:
            baseClass: 'my-icon',
            classPrefix: 'my-icon--',
            mixinPrefix: 'my-icon-'
    # replace:
    #   dist:
    #     src: ["scss/_icon.scss"]
    #     overwrite: true
    #     replacements: [
    #       from: ".icon_"
    #       to: ".icon--"
    #     ]
    imageoptim:
      src: ["img"]
      options:
        jpegMini: false
        imageAlpha: true
        quitAfter: true
    copy:
      js:
        expand: true
        flatten: true
        src: [
          "bower_components/jquery/jquery.min.js"
          "bower_components/box-sizing-polyfill/boxsizing.htc"
        ]
        dest: "public/js/vendor/"
        filter: "isFile"
      normalizecss:
        src: "bower_components/normalize-css/normalize.css"
        dest: "scss/_normalize.scss"
      animatecss:
        src: "bower_components/animate.css/animate.min.css"
        dest: "scss/_animate.scss"
      fontAwesomeFont:
        expand: true
        cwd: "bower_components/font-awesome/fonts/"
        src: "**"
        dest: "public/fonts/"
        filter: "isFile"
        flatten: true
      fontAwesomeSCSS:
        expand: true
        cwd: "bower_components/font-awesome/scss/"
        src: "_**"
        dest: "scss/font-awesome/"
        filter: "isFile"
        flatten: true
      # bootstrap:
      #   expand: true
      #   cwd: "bower_components/bootstrap-sass-official/vendor/assets/stylesheets/bootstrap"
      #   src: "_**"
      #   dest: "scss/bootstrap/"
      #   filter: "isFile"
      #   flatten: true
    concat:
      dist:
        src: [
          "js/plugins-base.js"
          "bower_components/jquery.transit/site/jquery.transit-0.9.9.min.js"
          "bower_components/respond/dest/respond.min.js"
        ]
        dest: "public/js/plugins.js"
    csso:
      dynamic_mappings:
        options:
          restructure: false
        expand: true
        cwd: "public/css/"
        src: ['*.css']
        dest: "public/css/"
    # KSS styleguide generator for grunt.
    kss:
      options:
        includeType: 'css'
        includePath: 'public/css/main.css'
        template: 'docs/template'
      dist:
        files:
          # dest : src
          'docs/styleguide': ['scss']
    cssshrink:
      target:
        src: "public/css/*.css"
        dest: "public/css/"



  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-webfont"
  grunt.loadNpmTasks "grunt-text-replace"
  grunt.loadNpmTasks "grunt-imageoptim"
  grunt.loadNpmTasks "grunt-autoprefixer"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-copy"
  # grunt.loadNpmTasks "grunt-csso"
  grunt.loadNpmTasks 'grunt-kss'
  grunt.loadNpmTasks 'grunt-cssshrink'

  grunt.registerTask "default", ["watch"];
  grunt.registerTask "min", ["coffee", "uglify", "compass:pro", "autoprefixer", "cssshrink", "kss"]
  grunt.registerTask "icon", ["webfont"]
  grunt.registerTask "init", ["copy", "concat", "uglify"]
