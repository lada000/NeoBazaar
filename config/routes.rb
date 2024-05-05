Rails.application.routes.draw do
  resources :cart_items
  resources :orders
  resources :categories
  resources :payments
  resources :carts
  resources :products
  resources :users

  mount User::API => '/'
  mount Product::API => '/product/product_api'
  mount Cart::API => '/cart/cart_api'
  mount CartItem::API => '/cart_item/cart_item_api'
  mount Category::API => '/category/category_api'
  mount Order::API => '/order/order_api'
  mount Payment::API => '/payment/payment_api'

  get "up" => "rails/health#show", as: :rails_health_check

end
