Rails.application.routes.draw do

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  root 'homes#top'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get "home/about" => "homes#about"


end