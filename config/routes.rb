Rails.application.routes.draw do
  resources :cart_items
  resources :orders
  resources :categories
  resources :payments
  resources :carts
  resources :products
  resources :users

  mount Users::API => '/'
  mount Products::API => '/'
  mount Carts::API => '/'
  mount CartItems::API => '/'
  mount Categorys::API => '/'
  mount Orders::API => '/'
  mount Payments::API => '/'

  get "up" => "rails/health#show", as: :rails_health_chec

end
