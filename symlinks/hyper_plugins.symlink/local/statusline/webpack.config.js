// const webpack = require('webpack')

module.exports = {
  mode: 'development',
  target: 'node',
  entry: ['@babel/polyfill', './src/index.js'],
  output: {
    path: __dirname + '/dist',
    filename: 'index.js',
    libraryTarget: 'commonjs',
  },
  externals: ['electron', 'hyper/component', 'hyper/notify', 'hyper/decorate'],
  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
      },
    ],
  },
}
