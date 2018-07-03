import React from 'react';
import { storiesOf } from '@storybook/react';
import Game2048 from 'Components/Game2048';

const Game2048Screen = () => <Game2048 />;

storiesOf('Example apps', module).add('Game2048', Game2048Screen);
