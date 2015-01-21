webpack = require("webpack")
path = require("path")

webpackPlugins = []

webpackPlugins.push new webpack.ResolverPlugin [
  new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin "bower.json", ["main"]
]

webpackPlugins.push new webpack.DefinePlugin
  SSPM_WEBAPI_HOST: JSON.stringify(process.env.SSPM_WEBAPI_HOST || "sspm.herokuapp.com")
  SSPM_WEBAPI_VERSION: JSON.stringify(process.env.SSPM_WEBAPI_VERSION || "v0")
  SSPM_WEBAPI_PROTOCOL: JSON.stringify(process.env.SSPM_WEBAPI_PROTOCOL || "https")
  SSPM_LOCAL_STORAGE: false

webpackPlugins.push new webpack.optimize.UglifyJsPlugin
  compress:
    warnings: false

module.exports =
  
  entry: [
    "main"
  ]

  resolve:
    root: [
      path.join(__dirname, "../bower_components")
      path.join(__dirname, "../bower_components/social-snippet-registry-assets/src/coffee")
    ]

    extensions: [
      ""
      ".coffee"
      ".js"
    ]

  externals:
    "jquery": "jQuery"

  output:
    filename: "[name].js"
    path: path.join(__dirname, "..", "public/js/")
    publicPath: "/js/"

  module:
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]

  plugins: webpackPlugins
