import { combineReducers } from 'redux';


const initialState = {
  searchUrlInput: ''
};


const UPDATE_SEARCH_URL = "UPDATE_SEARCH_URL"

const searchUrlReducer = (state = initialState.searchUrlInput, action) => {
  if(action.type === UPDATE_SEARCH_URL) {
    return action.value
  }
  return state;
};




const rootReducer = combineReducers({
  searchUrlInput: searchUrlReducer
});


export default rootReducer
