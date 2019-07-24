
import React from 'react';

class UrlSearchBar extends React.Component {
  constructor() {
    super()

    this.state = {
      inputUrl: ''
    }
  }
  render() {

  const captionTitle = () => { return ( <h1 class="display-4">Bootstrap 4</h1> ) }

  const handleSubmit = event => {

        event.preventDefault()
        this.props.updateLoading(true)
        this.props.search(this.props.currentPhone)

  }

  const handleChange = event => {
    this.setState({
      inputUrl: event.target.value
    })
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
                      <input onChange={handleChange} id="1" class="form-control" value={this.state.inputUrl} type="text" name="search" placeholder="Enter a url..." required/>
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


export default UrlSearchBar
