Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
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
