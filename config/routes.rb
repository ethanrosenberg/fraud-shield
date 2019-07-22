Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

get '/', to: 'messages#test'

  resource :messages do
  collection do
    post 'reply'
  end
end

end
