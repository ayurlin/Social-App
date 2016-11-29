Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  resources :user_friendships, :path => '/friends' do
    member do
      put :accept
    end
  end
  resources :posts do
      resources :comments
  end
  resources :users, except:[:new]
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/friends', to: 'user_friendships#index'
  root 'pages#index'
  
end
