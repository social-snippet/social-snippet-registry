_ = require "lodash"
gulp    = require "gulp"
bower   = require "bower"
coffee  = require "gulp-coffee"
concat  = require "gulp-concat"
uglify  = require "gulp-uglify"
ignore  = require "gulp-ignore"
debug   = require "gulp-debug"
ejs     = require "gulp-ejs"
main_bower_files  = require "main-bower-files"
amd_optimizer     = require "amd-optimize"
minify_css = require "gulp-minify-css"

gulp.task "app_config", ->
  gulp.src ["./assets/app_config.coffee.ejs"]
    .pipe ejs()
    .pipe concat "app_config.coffee"
    .pipe gulp.dest "tmp/coffee/"

gulp.task "coffee", ["app_config"], ->
  sources = [
    "./tmp/coffee/app_config.coffee"
    "./assets/main.coffee"
  ]
  gulp.src sources
    .pipe coffee()
    .pipe concat "main.js"
    .pipe gulp.dest "tmp/"

gulp.task "bower", (done)->
  bower.commands.install().on "end", ->
    gulp.src main_bower_files()
      .pipe ignore.include(/\.(js|css)$/)
      .pipe gulp.dest "tmp/lib/"
      .on "end", ->
        done()
  return undefined

gulp.task "bower/uglify", ["bower"], ->
  gulp.src ["tmp/lib/**/*.js"]
    .pipe ignore.exclude(/assets\.js$/)
    .pipe uglify(preserveComments: 'some')
    .pipe gulp.dest "tmp/lib/"

gulp.task "extlib", ["bower/uglify"], ->
  gulp.src "assets/extlib.coffee"
    .pipe coffee()
    .pipe amd_optimizer(
      "extlib"
      {
        configFile: gulp.src("assets/requirejs_config.coffee").pipe(coffee())
      }
    )
    .pipe uglify(preserveComments: 'some')
    .pipe concat "extlib.js"
    .pipe gulp.dest "tmp/"

gulp.task "lib", ["bower/uglify", "extlib"], ->
  lib_sources = [
    "./tmp/lib/require.js"
    "./tmp/extlib.js"
    "./tmp/lib/assets.js"
  ]
  gulp.src lib_sources
    .pipe concat "lib.js"
    .pipe gulp.dest "tmp/"

gulp.task(
  "build/script"
  [
    "lib"
    "coffee"
  ]
  ->
    sources = [
      "tmp/lib.js"
      "tmp/main.js"
    ]
    gulp.src sources
      .pipe concat "main.js"
      .pipe gulp.dest "public/js/"
)

gulp.task "build/fonts", ["bower/uglify"], ->
  fonts = [
    "./bower_components/font-awesome/fonts/fontawesome-webfont.*"
    "./bower_components/bootstrap/fonts/glyphicons-halflings-regular.*"
  ]
  gulp.src fonts
    .pipe gulp.dest "public/fonts/"

gulp.task "build/style", ["bower"], ->
  styles = [
    "./assets/css_header.css"
    "./tmp/lib/bootstrap.css"
    "./bower_components/bootstrap-social/bootstrap-social.css"
    "./bower_components/font-awesome/css/font-awesome.min.css"
    "./tmp/lib/assets.css"
  ]
  gulp.src styles
    .pipe concat "main.css"
    .pipe minify_css()
    .pipe gulp.dest "public/css/"

gulp.task "build",  [
  "build/script"
  "build/style"
  "build/fonts"
]

gulp.task "default", ["build"]

