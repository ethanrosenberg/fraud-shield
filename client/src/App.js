import React from 'react';
import logo from './logo.svg';
import './App.css';

import NavigationBar from './components/NavigationBar'
import SearchUrlContainer from './containers/SearchUrlContainer'
import { Switch, Route } from 'react-router-dom';


function App() {
  return (
    <div className="App">
    <NavigationBar />
    <Switch>
      <Route exact path="/" component={SearchUrlContainer} />
    </Switch>
    </div>
  );
}

export default App;
