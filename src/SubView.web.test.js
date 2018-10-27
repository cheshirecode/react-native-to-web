import React from 'react';
import ReactDOM from 'react-dom';

import SubView from './SubView';

it('SubView renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<SubView />, div);
  ReactDOM.unmountComponentAtNode(div);
});
