const path = require('path');

const config = {
  context: __dirname,
  entry: {
    gmis2017: './gmis/gmis2017.js'
  },
  output: {
    path: path.resolve(__dirname, './public/assets/js'),
    filename: '[name].js',
    publicPath: '/assets/',
    libraryTarget: 'umd'
  },
  module: {
    noParse: [],
    loaders: [
      {
        test: /\.(jsx|js)?$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.(png|jpg|gif)$/,
        loader: 'url-loader?limit=25000'
      },
      {
        test: /\.css$/,
        loader: 'style!css!autoprefixer',
        include: /node_modules/
      }
    ]
  },
  resolve: {
    root: path.join(__dirname, 'webpack/'),
    extensions: ['', '.js', '.jsx', '.json'],
    alias: []
  },
  cache: false,
  externals: {
    jquery: 'jQuery'
  },
  plugins: []
};


module.exports = config;
