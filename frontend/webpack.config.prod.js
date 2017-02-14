const webpack = require('webpack');
const merge = require('webpack-merge');
const baseConfig = require('./webpack.config.base');
const ManifestPlugin = require('webpack-manifest-plugin');

const config = merge(baseConfig, {
  output: {
    filename: '[name]-[hash].js'
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    new ManifestPlugin({
      fileName: 'webpack_manifest.json'
    })
  ]
});

module.exports = config;
