module.exports = {
  env: {
    'react-native/react-native': true
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-native/all',
    'prettier',
    'prettier/react'
  ],
  parser: 'babel-eslint',
  parserOptions: {
    ecmaVersion: 8,
    sourceType: 'module'
  },
  plugins: ['babel', 'react', 'react-native', 'prettier']
};
