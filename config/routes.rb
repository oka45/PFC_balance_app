Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to:'static_pages#about'
  get '/management', to:'static_pages#management'
  get '/signup', to:'users#new'
end
