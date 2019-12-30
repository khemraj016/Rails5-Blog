Rails.application.routes.draw do
  get 'posts/edit'
  get 'posts/new'
  get 'posts/show'
  devise_for :users
  
  root to: "home#index"

  resources :posts
  resources :comments
end
