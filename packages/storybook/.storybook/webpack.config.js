//modified heavily from https://github.com/necolas/react-native-web/blob/master/packages/website/storybook/.storybook/webpack.config.js
const path = require('path');
const webpack = require('webpack');
const bundlerConfig = require('@rntw/bundler-config');

const {
  rootPath,
  modulesToCompile,
  // babelConfig,
  moduleAliases
} = bundlerConfig();

const RELATIVE_PATH_TO_ROOT = '../../../';
module.exports = storybookBaseConfig => {
  storybookBaseConfig.module.rules = storybookBaseConfig.module.rules.map(
    rule =>
      rule.test.toString().indexOf('jsx') >= 0
        ? {
            ...rule,
            include: [
              ...(rule.include || []),
              `${rootPath}/src`,
              ...modulesToCompile.map(x => `${rootPath}/node_modules/${x}`)
            ]
          }
        : rule
  );
  storybookBaseConfig.module.rules.push({
    test: /\.(gif|jpe?g|png|svg)$/,
    use: {
      loader: 'url-loader',
      options: { name: '[name].[ext]' }
    }
  });

  storybookBaseConfig.resolve.extensions = [
    '.web.js',
    '.js',
    '.json',
    '.web.jsx',
    '.jsx'
  ];

  storybookBaseConfig.resolve.alias = {
    ...moduleAliases,
    'react-native': 'react-native-web',
    Components: path.resolve(
      __dirname,
      `${RELATIVE_PATH_TO_ROOT}/src/components/`
    )
  };

  return storybookBaseConfig;
};
