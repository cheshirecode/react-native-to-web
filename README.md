# react-native-to-web

This has a basic RN setup with
- [react-native-web](https://github.com/necolas/react-native-web/tree/master/packages/react-native-web)
- Split up bundler config to use in 2 Webpack setups (root and Storybook)

The plan is to add Rollup + Styleguidist

# Steps

- `create-react-native-app --with-web-support`
- `react-native eject`
- Rename folder and displayName in app.json
- `react-native relink`
- Fix anything that might have broken.

OR 

```
git clone git@github.com:cheshirecode/react-native-to-web.git
mv ./react-native-to-web ./<new name>
cd ./<new name>
yarn rename
```
