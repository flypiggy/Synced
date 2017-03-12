/* eslint-disable */
// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack')
const path = require('path')
const process = require('process')
const glob = require('glob')
const extname = require('path-complete-extname')

let distDir = process.env.WEBPACK_DIST_DIR

if (distDir === undefined) {
  distDir = 'packs'
}

const config = {
  entry: glob.sync(path.join('app', 'javascript', 'packs', '*.js*')).reduce(
    (map, entry) => {
      const basename = path.basename(entry, extname(entry))
      const localMap = map
      localMap[basename] = path.resolve(entry)
      return localMap
    }, {}
  ),

  output: { filename: '[name].js', path: path.resolve('public', distDir) },

  module: {
    rules: [
      {
        test: /\.js(\.erb)?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: [
            ['env', { modules: false }]
          ],
          plugins: [
            ["transform-object-rest-spread", { "useBuiltIns": true }]
          ]
        }
      },
      {
        test: /\.erb$/,
        enforce: 'pre',
        exclude: /node_modules/,
        loader: 'rails-erb-loader',
        options: {
          runner: 'DISABLE_SPRING=1 bin/rails runner'
        }
      },
      {
        test: /\.(png|jpg|gif)$/,
        loader: 'url-loader?limit=25000'
      },
      {
        test: /\.css$/,
        loader: 'style-loader!css-loader!autoprefixer-loader',
        include: /node_modules/
      },
      {
        test: /\.(ttf|eot|svg|mp4|woff(2)?)(\?[a-z0-9]+)?$/,
        loader: 'file-loader'
      }
    ]
  },

  plugins: [
    // new webpack.EnvironmentPlugin(Object.keys(process.env) || "NODE_ENV")
    new webpack.EnvironmentPlugin(["NODE_ENV"])
  ],

  resolve: {
    extensions: ['.js'],
    modules: [
      path.resolve('app/javascript'),
      path.resolve('node_modules')
    ]
  },

  resolveLoader: {
    modules: [path.resolve('node_modules')]
  },

  externals: {
    "jquery": "jQuery"
  }
}

module.exports = {
  distDir,
  config
}
