// Generated by CoffeeScript 1.10.0
var _, coffeelint, transformOptions, transformTools;

_ = require('lodash');

coffeelint = require('coffeelint');

coffeelint.reporter = require('coffeelint-stylish').reporter;

coffeelint.configfinder = require('coffeelint/lib/configfinder');

transformTools = require('browserify-transform-tools');

transformOptions = {
  includeExtensions: ['.coffee']
};

module.exports = transformTools.makeStringTransform('coffeelint', transformOptions, function(content, config, done) {
  var error, error1, errorReport, errors, fileOptions, options;
  try {
    errorReport = coffeelint.getErrorReport();
    fileOptions = coffeelint.configfinder.getConfig() || {};
    options = _.defaults(config.opts, fileOptions);
    errors = errorReport.lint(config.file, content, options);
    if (errors.length !== 0) {
      coffeelint.reporter(config.file, errors);
      if (options.doEmitErrors && errorReport.hasError()) {
        throw new Error("coffeelint has errors");
      }
      if (options.doEmitWarnings && _.some(errorReport.paths, function(o, p) {
        return errorReport.pathHasWarning(p);
      })) {
        throw new Error("coffeelint has warnings");
      }
    }
    return done(null, content);
  } catch (error1) {
    error = error1;
    return done(error);
  }
});
