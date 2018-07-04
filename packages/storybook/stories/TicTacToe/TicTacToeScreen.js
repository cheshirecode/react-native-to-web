import React from 'react';
import { storiesOf } from '@storybook/react';
import TicTacToe from 'Components/TicTacToe';

const TicTacToeScreen = () => <TicTacToe />;

storiesOf('Example apps', module).add('TicTacToe', TicTacToeScreen);
