Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
  
  # Rota para signup
  get '/signup', to: 'sessions#signup'
  post '/signup', to: 'sessions#create_user'

  # Rota para obter o usuário atual
  get '/current_user', to: 'sessions#current_user'

  resources :tasks

end
