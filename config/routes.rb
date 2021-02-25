Rails.application.routes.draw do
  get '/management', to: 'search#search'
  root 'static_pages#home'
  get '/about', to:'static_pages#about'
  get '/signup', to:'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'
  resources :users
end
