export const updateSearchUrl = event => {
  return {
    type: "UPDATE_SEARCH_URL",
    value: event.target.value
  };
};
