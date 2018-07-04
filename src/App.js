import React from 'react';
import { StyleSheet, Text, ScrollView, Platform } from 'react-native';
import SubView from './SubView';
import Game2048 from './components/Game2048';
import TicTacToe from './components/TicTacToe';
export default class App extends React.Component {
  render() {
    return (
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.contentContainer}
      >
        <Text>Open up src/App.js to start working on your app!</Text>
        <Text>Changes you make will automatically reload.</Text>
        {Platform.OS !== 'web' && (
          <Text>Shake your phone to open the developer menu.</Text>
        )}
        <SubView />
        <Game2048 />
        <TicTacToe />
      </ScrollView>
    );
  }
}
const styleSheet = {
  container: {
    flex: 1,
    backgroundColor: '#fff'
  },
  contentContainer: {
    alignItems: 'center',
    justifyContent: 'center'
  }
};
const styles = StyleSheet.create(styleSheet);
