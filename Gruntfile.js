/*global module:false*/
module.exports = function(grunt) {
  require("matchdep").filterAll("grunt-*").forEach(grunt.loadNpmTasks);
  var webpack = require("webpack");
  var webpack_options = require('./webpack.config.js');

  grunt.initConfig({
    //
    // Dev watch taks
    //

    watch: {
      webpack: {
        files: [
          "src/**/*",
        ],
        tasks: ["webpack:build-dev"],
        options: {
          spawn: false,
        }
      }
    },
    //
    // Clean 'dist' folder
    //

    clean: {
      build: {
        src: ['dist']
      }
    },

    webpack: {
      options: webpack_options,
      build: {
        plugins: webpack_options.plugins.concat(
          new webpack.DefinePlugin({
            "process.env": {
              // This has effect on the react lib size
              "NODE_ENV": JSON.stringify("production")
            }
          }),
          new webpack.optimize.DedupePlugin(),
          new webpack.optimize.UglifyJsPlugin()
        )
      },
      "build-dev": {
        plugins: webpack_options.plugins.concat( new webpack.DefinePlugin({"process.env": { "NODE_ENV": JSON.stringify("development") } })),
        devtool: "sourcemap",
        debug: true
      }
    },

  });


  grunt.registerTask("build_dev_js", ["webpack:build-dev", "watch:webpack"]);
  grunt.registerTask("build_dev", ["clean", "webpack:build"]);
};
