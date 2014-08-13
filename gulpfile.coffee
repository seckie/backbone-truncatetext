gulp = require('gulp')
gutil = require('gulp-util')

coffee = require('gulp-coffee')
coffeelint = require('gulp-coffeelint')
jshint = require('gulp-jshint')
stylus = require('gulp-stylus')
nib = require('nib')

fs = require('fs')

paths = {
  coffee: 'src/truncatetext.coffee'
  coffeeDest: 'dist/truncatetext.js'
  staticJs: [
    'bower_components/jquery/dist/jquery.min.js'
    'bower_components/underscore/underscore.js'
    'bower_components/backbone/backbone.js'
  ]
  staticJsDest: [
    'demo/jquery.min.js'
    'demo/underscore.js'
    'demo/backbone.js'
  ]
  stylus: 'src/**/*.styl'
  stylusDest: 'demo'
}


###
 * Coffee Script
###

gulp.task('coffee', (callback) ->
  coffeeStream = coffee({ bare: true }).on('error', (err) ->
    gutil.log(err)
    coffeeStream.end()
  )
  coffeelintStream = coffeelint(
    'no_trailing_whitespace':
      'level': 'error'
  ).on('error', (err) ->
    gutil.log(err)
    coffeelintStream.end()
  )
  gulp.src(paths.coffee)
    .pipe(coffeelintStream)
    .pipe(coffeelint.reporter())
    .pipe(coffeeStream)
    .pipe(gulp.dest('dist'))
)


###
 * jshint
###

gulp.task('jshint', (callback) ->
  jshintStream = jshint().on('error', (err) ->
    gutil.log(err)
    jshintStream.end()
  )
  gulp.src(paths.coffeeDest)
    .pipe(jshintStream)
    .pipe(jshint.reporter('default'))
)


###
 * Stylus
###

gulp.task('stylus', (callback) ->
  stream = stylus(
    use: [ nib() ]
  ).on('error', (err) ->
    gutil.log(err)
    stream.end()
  )

  gulp.src(paths.stylus)
    .pipe(stream)
    .pipe(gulp.dest(paths.stylusDest))
)


###
 * Copy
###

gulp.task('copy', () ->
  for sr, i in paths.staticJs
    src = paths.staticJs[i]
    dest = paths.staticJsDest[i]
    fs.createReadStream(src).pipe(fs.createWriteStream(dest))
)


###
 * watch
###

gulp.task('watch', () ->
  gulp.watch(paths.coffee, [
    'coffee'
  ])
  gulp.watch(paths.scss, [
    'compassDev'
  ])
)


###
 * command
###

gulp.task('default', [
  'coffee'
  'jshint'
  'stylus'
  'watch'
])

gulp.task('deploy', [
  'copy'
  'coffee'
  'jshint'
  'stylus'
])

