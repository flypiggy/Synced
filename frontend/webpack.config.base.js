const path = require('path');

const config = {
  context: __dirname,
  entry: {
    gmis2017: './gmis/gmis2017.js'
  },
  output: {
    path: path.resolve(__dirname, 'static/'),
    filename: '[name].js',
    publicPath: '/static/',
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
      },
      {
        test: /\.(ttf|eot|svg|mp4|woff(2)?)(\?[a-z0-9]+)?$/,
        loader: 'file-loader'
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
