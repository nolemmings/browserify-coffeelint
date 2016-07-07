_                       = require 'lodash'
coffeelint              = require 'coffeelint'
coffeelint.reporter     = require('coffeelint-stylish').reporter
coffeelint.configfinder = require('coffeelint/lib/configfinder')
transformTools          = require 'browserify-transform-tools'

transformOptions =
  includeExtensions: ['.coffee']

module.exports = transformTools.makeStringTransform 'coffeelint',
  transformOptions,
  (content, config, done) ->
    try
      errorReport = coffeelint.getErrorReport()
      fileOptions = coffeelint.configfinder.getConfig() or {}

      options = _.defaults config.opts, fileOptions

      errors = errorReport.lint config.file, content, options
      if errors.length isnt 0
        coffeelint.reporter config.file, errors

        if options.doEmitErrors and errorReport.hasError()
          throw new Error ("coffeelint has errors")

        if options.doEmitWarnings and
           _.some(errorReport.paths, (o, p) ->
             errorReport.pathHasWarning(p))
          throw new Error ("coffeelint has warnings")

      done null, content

    catch error
      done error

