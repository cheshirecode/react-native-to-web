# react-native-web-with-storybook

Example of RN with:

- [react-native-web](https://github.com/necolas/react-native-web/tree/master/packages/react-native-web)
- Storybook

# Steps

- `create-react-native-app --with-web-support`
- `react-native eject`
- Rename folder and displayName in app.json
- `react-native relink`
- Set up Storybook:
  - As website package to publish on Github's gh-pages
  - Separate Webpack config (simpler and covers)
  -
