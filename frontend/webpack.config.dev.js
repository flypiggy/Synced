const webpack = require('webpack');
const merge = require('webpack-merge');
const baseConfig = require('./webpack.config.base');

const config = merge(baseConfig, {
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify('development')
      }
    }),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
  ],
  devServer: {
    proxy: {
      '*': 'http://127.0.0.1:3000'
    },
    devtool: false,
    port: 9000,
    host: '0.0.0.0',
    compress: true,
    hot: true,
    lazy: false,
    stats: {
      warnings: false,
      chunkModules: false
    }
  },
  devtool: 'source-map'
});

module.exports = config;
