export const updateSearchUrl = event => {
  return {
    type: "UPDATE_SEARCH_URL",
    value: event.target.value
  };
};

export const updateLoading = value => {
  return {
    type: "UPDATE_LOADING",
    value
  };
};

export const updateUrlResults = value => {
  return {
    type: "UPDATE_URL_RESULTS",
    value
  };
};



export const searchURL = input => {

  return dispatch => {

    dispatch(updateLoading(true))

    const headers = {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ query: input })
    }

    fetch('http://localhost:3000/api/v1/searchUrl', headers)
      .then(r => r.json())
      .then(response => {
          dispatch(updateSearchUrl(response))
          dispatch(updateLoading(false))

      })
  }
}
