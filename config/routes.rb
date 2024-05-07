Rails.application.routes.draw do
  resources :cart_items
  resources :orders
  resources :categories
  resources :payments
  resources :carts
  resources :products
  resources :users

  mount API => '/'

end
