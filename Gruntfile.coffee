module.exports = (grunt) ->

  grunt.initConfig

    # Clean public directory
    clean: ['public/']

    # Compilation `.coffee` files from `dev/**` dir to `public/**` dir
    # It does not adds function wrappers
    # and creates `.map` sourcemap files. You should endble source map in Chrome
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

    # Creates static server which serves foles from `.` folder on 8080 port.
    # Also on each file change it reloads page
    connect:
      server:
        options:
          port: 8080
          base: './'
          livereload: on

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

    # Run unittests in real browsers. Required to be in background because 
    # it blocks regarde / watch
    karma:
      unit:
        configFile: 'public/tests/karma-config.js'
        background: on

    # Watch files and run tasks when any of this file was changed
    # Newer allows compile only changed files
    watch:
      options:
        livereload: on
      html:
        files: ['index.html', 'dev/**/*.html', 'dev/**/*.hbs']
        tasks: ['copy']
      js:
        files: ['dev/**/*.coffee', 'dev/**/*.js']
        tasks: ['newer:coffee', 'karma:unit:run', 'coffeelint']

  # Load plugins
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-newer'

  # Declaring tasks
  grunt.registerTask 'run', 'Start development flow', ->
    tasks = [
      'clean',
      'coffee',
      'copy',
      'coffeelint',
      'connect',
      'karma',
      'watch'
    ]
    grunt.option 'force', true
    grunt.task.run tasks

  grunt.registerTask 'build', ['clean', 'coffee']

  grunt.registerTask 'default', ['run']
