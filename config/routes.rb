Rails.application.routes.draw do
  
  resources :posts do
      resources :comments
  end
  resources :users, except:[:new]
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'pages#index'
end
