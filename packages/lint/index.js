module.exports = {
  env: {
    'react-native/react-native': true
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-native/all',
    'plugin:import/errors',
    'plugin:import/warnings',
    'prettier',
    'prettier/react'
  ],
  parser: 'babel-eslint',
  parserOptions: {
    ecmaVersion: 8,
    sourceType: 'module'
  },
  plugins: ['babel', 'react', 'react-native', 'prettier'],
  rules: {
    'react/prop-types': 0,
    'import/no-unresolved': [2, { ignore: ['react-?', 'Components/?'] }]
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.ios.js', '.android.js', '.web.js']
      }
    }
  }
};
