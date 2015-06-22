through             = require 'through2'
coffeelint          = require 'coffeelint'
coffeelint.reporter = require('coffeelint-stylish').reporter
coffeelint.configfinder = require('coffeelint/lib/configfinder')

module.exports = (file, options = {}) ->
  errorReport = coffeelint.getErrorReport()
  fileOpts = coffeelint.configfinder.getConfig()

  through (buf, enc, next) ->
    # Lint!
    if file.substr(-7) is '.coffee'
      errors = errorReport.lint file, buf.toString(), fileOpts
      if errors.length isnt 0
        coffeelint.reporter file, errors

    # Just pass it through
    @push buf
    next()
