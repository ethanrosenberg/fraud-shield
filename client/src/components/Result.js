
import React from 'react';
import { connect } from 'react-redux';

class Result extends React.Component {

  render() {




    return (
      <center>
      <img src={this.props.image_url} />
      <h1 class="display-4">{this.props.brand}</h1>
      </center>
    )

  }


}

const mapStateToProps = state => {
  return {
    brand: state.urlResults.flag,
    image_url: state.urlResults.image_url
  }
}



export default connect(mapStateToProps)(Result)
