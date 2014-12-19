through             = require 'through2'
coffeelint          = require 'coffeelint'
coffeelint.reporter = require('coffeelint-stylish').reporter

module.exports = (file, options = {}) ->
  through (buf, enc, next) ->
    # Lint!
    if file.substr(-7) is '.coffee'
      errors = coffeelint.lint buf.toString('utf8'), options
      if errors.length isnt 0
        coffeelint.reporter file, errors

    # Just pass it through
    @push buf
    next()