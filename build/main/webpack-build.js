var webpack = require('webpack')
var path = require('path')
var Promise = require('bluebird')
var fs = Promise.promisifyAll(require('fs-extra'))

// returns a Compiler instance
var compiler = webpack({
  context: path.join(__dirname, '..', '..'),
  entry: {
    'hexagon.test': 'mocha!./modules/hexagon.test'
  },
  output: {
    path: path.join(__dirname, '..', '..', 'target', 'test'),
    filename: '[name].js',
    library: 'hx',
    libraryTarget: 'umd'
  },
  module: {
    loaders: [
      { test: /spec.js$/, loader: 'babel', exclude: [/node_modules/] },
      { test: /.js$/, loader: 'isparta', exclude: [/spec.js$/, /node_modules/] },
      { test: /spec.coffee$/, loader: 'coffee', exclude: [/node_modules/]},
      { test: /.coffee$/, loader: 'coffee-coverage', exclude: [/spec.coffee$/, /node_modules/] }
    ]
  },
  resolve: {
    extensions: ['', '.coffee', '.js', '.json']
  }
})

var lastHash = undefined
compiler.watch({}, function (err, stats) {
  if (err) {
    console.error(err)
  } else if (stats.hash !== lastHash) {
    lastHash = stats.hash
    console.log(stats.toString({
      chunks: false,
      colors: require('supports-color')
    }))
  }
})

fs.copyAsync(path.join(__dirname, 'test.html'), path.join(__dirname, '..', '..', 'target', 'test', 'index.html'))
