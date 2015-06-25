_                       = require 'lodash'
through                 = require 'through2'
coffeelint              = require 'coffeelint'
coffeelint.reporter     = require('coffeelint-stylish').reporter
coffeelint.configfinder = require('coffeelint/lib/configfinder')

module.exports = (file, overrideOptions = {}) ->
  errorReport = coffeelint.getErrorReport()
  fileOptions = coffeelint.configfinder.getConfig() or {}

  options = _.defaults overrideOptions, fileOptions

  through (buf, enc, next) ->
    # Lint!
    if file.substr(-7) is '.coffee'
      errors = errorReport.lint file, buf.toString(), options
      if errors.length isnt 0
        coffeelint.reporter file, errors

    # Just pass it through
    @push buf
    next()