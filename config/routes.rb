Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :passwords], controllers: {
    registrations: 'users/registrations'
  }
  resources :cart_items
  resources :orders
  resources :categories
  resources :payments
  resources :carts
  resources :products
  resources :users

  root 'home#index'

  mount API => '/'
end
