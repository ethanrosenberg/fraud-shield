import React from 'react';
import logo from '../logo.svg';
import Navbar from 'react-bootstrap/Navbar';
import Nav from 'react-bootstrap/Nav';
import image from "../components/email.png";
import UrlSearchBar from "../components/UrlSearchBar";
import Result from "../components/Result"

import { Link } from 'react-router-dom'
import { connect } from 'react-redux';

class SearchUrlContainer extends React.Component {

render() {

  const showResults = () => {
    return (
      <div className="results">
      <br></br>
      <Result />
      </div>
    )
  }

  const showSearchBar = () => {
    return (
      <div className="bg">
      <UrlSearchBar />
      </div>
    )
  }
  return (

      this.props.results.flag ? showResults() : showSearchBar()

  )

}




}

const mapStateToProps = state => {
  return {
    results: state.urlResults,
  }
}


export default connect(mapStateToProps)(SearchUrlContainer)
