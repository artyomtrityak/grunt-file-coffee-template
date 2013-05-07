path = require 'path'
lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet

folderMount = (connect, point) ->
  connect.static path.resolve(point)

folderDir = (connect, point) ->
  connect.directory path.resolve(point)

module.exports = (grunt) ->

  grunt.initConfig

    # Clean public directory
    clean: ['public/']

    coffee:
      options:
        bare: true
        sourceMap: true

      glob_to_multiple:
        expand: true
        cwd: 'dev/'
        src: ['**/*.coffee']
        dest: 'public/'
        ext: '.js'

    # Coffee linting all coffee files except vendor dir
    coffeelint:
      app: ['dev/**/*.coffee', '!**/vendor/**']

    connect:
      server:
        options:
          port: 8080
          base: './'
          middleware: (connect, options) ->
            [
              lrSnippet
              folderMount connect, './'
              folderDir connect, './'
            ]

    # We need to copy all static files from `dev/` directory 
    # to `public/` (build) directory
    copy:
      main:
        files: [
          expand: on
          cwd: 'dev/'
          src: ['**/*.css', '**/*.hbs', '**/*.js', '**/*.png', '**/*.gif', 'assets']
          dest: 'public/'
        ]

    # 
    karma:
      unit:
        configFile: 'public/tests/karma-config.js'
        background: on

    # Watch files and run tasks when any of this file was changed
    regarde:
      html:
        files: ['index.html', 'dev/**/*.html', 'dev/**/*.hbs']
        tasks: ['copy', 'livereload']
      js:
        files: ['dev/**/*.coffee', 'dev/**/*.js']
        tasks: ['coffee', 'karma:unit:run', 'coffeelint', 'livereload']

  # Load plugins
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-regarde'
  grunt.loadNpmTasks 'grunt-contrib-livereload'
  grunt.loadNpmTasks 'grunt-karma'

  # Declaring tasks
  grunt.registerTask 'run', 'Start development flow', ->
    tasks = [
      'clean',
      'coffee',
      'copy',
      'coffeelint',
      'connect',
      'karma',
      'livereload-start',
      'regarde'
    ]
    grunt.option 'force', true
    grunt.task.run tasks

  grunt.registerTask 'build', ['clean', 'coffee']

  grunt.registerTask 'default', ['run']
