module.exports = {
  entry: {
    'bundle'   : './src/index.coffee',
  },
  output: {
    filename: "./dist/[name].js",
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' },
    ]
  },
  plugins: [],
  resolve: {
    extensions: ['', '.js', '.coffee']
  }
};
