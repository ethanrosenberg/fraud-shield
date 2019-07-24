
import React from 'react';
import { connect } from 'react-redux';
import { searchURL, updateSearchUrl, updateLoading, updateUrlResults } from '../actions/searchUrlActions'

class UrlSearchBar extends React.Component {

  render() {

  const captionTitle = () => { return ( <h1 class="display-4">Bootstrap 4</h1> ) }

  const handleSubmit = event => {

        event.preventDefault()
        this.props.searchURL(this.props.searchUrlInput)

  }



    return (

      <section id="cover">
          <div id="cover-caption">
      <div id="container" class="container">
              <div class="row text-white">
                  <div class="col-sm-8 offset-sm-2 text-center">
                      <div class="info-form">
                      <form onSubmit={handleSubmit} role="form" id="form-buscar">
                      <div class="form-group">
                      <div class="input-group">
                      <input onChange={this.props.updateSearchUrl} id="1" class="form-control"  value={this.props.searchUrlInput} ype="text" name="search" placeholder="Enter a url..." required/>
                      <span class="input-group-btn">
                      <button class="btn btn-success" type="submit">
                      <i class="glyphicon glyphicon-search" aria-hidden="true"></i> Search
                      </button>
                      </span>
                      </div>
                      </div>
                      </form>
                      </div>
                  </div>
              </div>
          </div>
          </div>
</section>
    )
  }

}


const mapStateToProps = state => {
  return {
    searchUrlInput: state.searchUrlInput,
  }
}





export default connect(mapStateToProps, {searchURL, updateSearchUrl, updateLoading, updateUrlResults })(UrlSearchBar)
