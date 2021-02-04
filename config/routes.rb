Rails.application.routes.draw do
 
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  root 'homes#top'
  resources :books
  get "home/about" => "homes#about"
  
end