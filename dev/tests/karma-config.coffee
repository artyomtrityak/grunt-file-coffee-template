# Testacular configuration
# Generated on Tue Jan 29 2013 13:11:10 GMT+0200 (FLE Standard Time)


# base path, that will be used to resolve files and exclude
basePath = '../'



# list of files / patterns to load in the browser
files = [
  MOCHA
  MOCHA_ADAPTER

  {
    pattern: 'tests/vendor/*.js'
    included: true
    served: true
    watched: true
  }
  {
    pattern: 'app/assets/vendor/require-2.1.5.js'
    included: true
    served: true
    watched: true
  }
  'app/config.js'
  'tests/test-config.js'

  {pattern: 'app/*.js', included: false, served: true, watched: true}
  {pattern: 'app/**/*.js', included: false, served: true, watched: true}
  {pattern: 'app/**/*.hbs', included: false, served: true, watched: true}

  {pattern: 'tests/spec/**/*.js', included: true, served: true, watched: true}
]


# list of files to exclude
exclude = [

]


# test results reporter to use
# possible values: 'dots', 'progress', 'junit'
reporters = ['progress']


# web server port
port = 9876


# cli runner port
runnerPort = 9100


# enable / disable colors in the output (reporters and logs)
colors = off


logLevel = LOG_INFO


# enable / disable watching file and executing tests whenever any file changes
autoWatch = off


# Start these browsers, currently available:
# - Chrome
# - ChromeCanary
# - Firefox
# - Opera
# - Safari (only Mac)
# - PhantomJS
# - IE (only Windows)
browsers = ['Chrome']

captureTimeout = 60000

singleRun = off
