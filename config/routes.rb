Rails.application.routes.draw do
  get 'search_url/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/api/v1' do
    get '/twitterSearch', to: 'search#parse'
    post '/searchUrl', to: 'search_url#search'
  end
  
get '/', to: 'messages#test'

  resource :messages do
  collection do
    post 'reply'
  end
end





end
