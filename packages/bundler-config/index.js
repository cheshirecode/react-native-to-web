const path = require('path');
const rootPath = path.resolve(__dirname, '../../');
const pkg = require(`../core/package.json`);

module.exports = ({ extraDependencies = [], extraAliases = {} } = {}) => {
  //list any RN libraries that were distributed as ES6 to run through Webpack, deduped
  const modulesToCompile = [
    ...new Set([
      'react-native-drawer',
      'react-native-platform-touchable',
      '@expo/vector-icons',
      'react-native-safe-area-view',
      'react-native-paper',
      'react-native-tab-view',
      'react-navigation',
      'static-container',
      ...Object.keys(pkg.dependencies).filter(
        x => x.startsWith('react-native-') || x.startsWith('@expo')
      ),
      ...extraDependencies
    ])
  ];

  const babelConfig = {
    // web bundler-only Babel configuration to
    // avoid conflict with RN
    plugins: [
      'expo-web',
      'react-native-web',
      'transform-decorators-legacy',
      [
        'transform-runtime',
        { helpers: false, polyfill: false, regenerator: true }
      ]
    ],
    // The 'react-native' preset is recommended to match React Native's packager
    presets: ['react-native']
  };

  const moduleAliases = {
    '@expo/vector-icons': 'expo-web',
    expo: 'expo-web',
    'react-native/Libraries/Renderer/shims/ReactNativePropRegistry':
      'react-native-web/dist/modules/ReactNativePropRegistry',
    'react-native': 'react-native-web',
    ...extraAliases
  };

  return {
    rootPath,
    modulesToCompile,
    babelConfig,
    moduleAliases
  };
};
