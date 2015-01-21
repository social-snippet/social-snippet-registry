gulp = require("gulp")

gulp.task "default", [
  "build"
]

gulp.task "bower", (done)->
  bower = require("bower")
  bower.commands.install().on "end", ->
    done()
  undefined

gulp.task "build/js", ["bower"], ->
  gulpWebpack = require("gulp-webpack")
  webpackConfig = require("./config/webpack")

  gulp.src "./bower_components/social-snippet-registry-assets/src/coffee/**/*.coffee"
    .pipe gulpWebpack(webpackConfig)
    .pipe gulp.dest("public/js/")

gulp.task "main.css/sass", ["bower"], ->
  sass = require("gulp-sass")
  sassSrc = [
    "./bower_components/social-snippet-registry-assets/src/sass/**/*.sass"
    "./bower_components/social-snippet-registry-assets/src/sass/**/*.scss"
  ]
  gulp.src sassSrc
    .pipe sass()
    .pipe gulp.dest("tmp/css/")

gulp.task "main.css/css", ["bower"], ->
  gulp.src ["./bower_components/social-snippet-registry-assets/src/css/**/*.css"]
    .pipe gulp.dest("tmp/css/")


gulp.task "main.css", ["bower", "main.css/sass", "main.css/css"], ->
  concat = require("gulp-concat")
  minify = require("gulp-minify-css")
  gulp.src ["tmp/css/*.css"]
    .pipe concat("main.css")
    .pipe minify()
    .pipe gulp.dest("public/css/")
 
gulp.task "build", [
  "build/js"
  "main.css"
]
