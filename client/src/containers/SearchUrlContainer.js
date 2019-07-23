import React from 'react';
import logo from '../logo.svg';
import Navbar from 'react-bootstrap/Navbar';
import Nav from 'react-bootstrap/Nav';
import image from "../components/email.png";
import UrlSearchBar from "../components/UrlSearchBar";

import { Link } from 'react-router-dom'

const SearchUrlContainer = () => {


    return (
      <div className="bg">
      <UrlSearchBar />
      </div>



    )

}

export default SearchUrlContainer
