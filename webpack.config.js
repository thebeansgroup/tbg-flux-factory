module.exports = {
  entry: {
    'bundle'   : './test/index.coffee',
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
