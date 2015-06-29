# Browserify Coffeelint transform

This simple 'transform' enables to integrate your coffeelint with browserify. This makes for a simpler watch, and only lints what you acutally use. Especially good with watchify.

## Install

```shell
npm install browserify-coffeelint --save-dev

```

## Use
Just use as normal transform. Transform options are passed through as coffeelint options.

```shell
browserify -t browserify-coffeelint -t coffeeify main.coffee -o bundle.js
```

## Config
It automatically looks for `coffeelint.json` in the default places (since 1.1.0). To generate such a file, execute:

```shell
coffeelint --makeconfig > coffeelint.json
```

It is also possible to set (/overide) these settings using browserify options.

Example using `package.json`:
```json
"browserify": {
  "transform": [
    [
      "browserify-coffeelint",
      {
        "arrow_spacing": {
          "name": "arrow_spacing",
          "level": "error"
        }
      }
    ]
  ]
}
```

Example using programmatic API:

```coffeescript
browserify            = require 'browserify'
browserify_coffeelint = require 'browserify-coffeelint'
coffeeify             = require 'coffeeify'

options = 
  arrow_spacing:
    name:  'arrow_spacing'
    level: 'error'

browserify()
.add 'main.coffee'
.transform browserify_coffeelint, options
.transform coffeeify
.bundle()
.pipe process.stdout
```
