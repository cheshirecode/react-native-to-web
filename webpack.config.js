//thanks to https://github.com/necolas/react-native-web/blob/master/packages/examples/webpack.config.js
const path = require('path');
const webpack = require('webpack');
const {
  modulesToCompile,
  babelConfig,
  moduleAliases
} = require('@rntw/bundler-config/default');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer')
  .BundleAnalyzerPlugin;

const appDirectory = path.resolve(__dirname, './');

// Many OSS React Native packages are not compiled to ES5 before being
// published. If you depend on uncompiled packages they may cause webpack build
// errors. To fix this webpack can be configured to compile to the necessary
// 'node_module'.
const babelLoaderConfiguration = {
  test: /\.js$/,
  // Add every directory that needs to be compiled by Babel during the build.
  include: [
    path.resolve(appDirectory, 'src'),
    ...modulesToCompile.map(x => `${appDirectory}/node_modules/${x}`)
  ],
  use: {
    loader: 'babel-loader',
    options: {
      // cacheDirectory: false,
      babelrc: false,
      ...babelConfig
    }
  }
};

// This is needed for loading css
const cssLoaderConfiguration = {
  test: /\.css$/,
  use: ['style-loader', 'css-loader']
};

const imageLoaderConfiguration = {
  test: /\.(gif|jpe?g|png|svg)$/,
  use: {
    loader: 'file-loader',
    options: {
      name: '[name].[ext]'
    }
  }
};

const ttfLoaderConfiguration = {
  test: /\.ttf$/,
  use: [
    {
      loader: 'file-loader',
      options: {
        name: './fonts/[hash].[ext]'
      }
    }
  ],
  include: [
    path.resolve(appDirectory, './src/assets/fonts'),
    path.resolve(appDirectory, 'node_modules/react-native-vector-icons')
  ]
};
const { NODE_ENV } = process.env;
const isDev = NODE_ENV === 'development';
module.exports = {
  // your web-specific entry file
  entry: path.resolve(appDirectory, 'src/index.web.js'),
  devtool: isDev ? 'inline-source-map' : 'source-map',

  // configures where the build ends up
  output: {
    filename: 'bundle.js',
    publicPath: '/assets/',
    path: path.resolve(appDirectory, './public/assets')
  },
  module: {
    rules: [
      babelLoaderConfiguration,
      cssLoaderConfiguration,
      imageLoaderConfiguration,
      ttfLoaderConfiguration
    ]
  },

  plugins: [
    // process.env.NODE_ENV === 'production' must be true for production
    // builds to eliminate development checks and reduce build size. You may
    // wish to include additional optimizations.
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(
        process.env.NODE_ENV || 'development'
      ),
      __DEV__: process.env.NODE_ENV === 'production' || true
    }),
    ...(process.env.ANALYZE
      ? [
          new BundleAnalyzerPlugin({
            analyzerMode: 'static',
            openAnalyzer: true
          })
        ]
      : [])
  ],
  mode: isDev || process.env.WEBPACK_SERVE ? 'development' : 'production',

  resolve: {
    // If you're working on a multi-platform React Native app, web-specific
    // module implementations should be written in files using the extension
    // '.web.js'.
    symlinks: false,
    extensions: ['.web.js', '.js'],
    alias: {
      ...moduleAliases
    }
  }
};
