"use strict";

var webpack = require("webpack");

module.exports = {
  entry: "./web/static/js/app.js",
  output: {
      path: "./priv/static/js",
      filename: "bundle.js"
  },
  module : {
    loaders : [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel'
      }
    ]
  }
};