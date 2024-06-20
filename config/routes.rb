Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :cart_items
  resources :orders
  resources :categories, only: %i[index show create update destroy]
  resources :payments, only: %i[index show create update destroy]
  resources :carts
  resources :products
  resources :users

  root 'home#index'

  mount API => '/'
end
