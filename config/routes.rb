Rails.application.routes.draw do
  resources :users, except:[:new]
  get 'signup' => 'users#new'
  root 'pages#index'
end
