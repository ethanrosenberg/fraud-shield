import { combineReducers } from 'redux';


const initialState = {
  searchUrlInput: '',
  loading: false,
  urlResults: []
};

const UPDATE_LOADING = 'UPDATE_LOADING';
const UPDATE_SEARCH_URL = "UPDATE_SEARCH_URL"
const UPDATE_URL_RESULTS = "UPDATE_URL_RESULTS"

const searchUrlReducer = (state = initialState.searchUrlInput, action) => {
  if(action.type === UPDATE_SEARCH_URL) {
    return action.value
  }
  return state;
};

const loadingReducer = (state = initialState.loading, action) => {
  if(action.type === UPDATE_LOADING) {
    return action.value
  }
  return state;
};

const currentUrlResultsReducer = (state = initialState.urlResults, action) => {
  if(action.type === UPDATE_URL_RESULTS) {
    return action.value
  }
  return state;
};





const rootReducer = combineReducers({
  searchUrlInput: searchUrlReducer,
  loading: loadingReducer,
  urlResults: currentUrlResultsReducer
});


export default rootReducer
