require_relative "boot"
require_relative '../app/api/users/api'
require_relative '../app/api/products/api'
require_relative '../app/api/carts/api'
require_relative '../app/api/cart_items/api'
require_relative '../app/api/categorys/api'
require_relative '../app/api/orders/api'
require_relative '../app/api/payments/api'

require "rails/all"

Bundler.require(*Rails.groups)

module NeoBazaar02
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
    config.api_only = true
  end

  # Загрузка и компиляция всех модулей API
  Users::API.compile!
  Products::API.compile!
  Carts::API.compile!
  CartItems::API.compile!
  Categorys::API.compile!
  Orders::API.compile!
  Payments::API.compile!

  GrapeAPI = Rack::Builder.new do
    map "/users" do
      run Users::API
    end

    map "/products" do
      run Products::API
    end

    map "/carts" do
      run Users::API
    end

    map "/cart_items" do
      run Products::API
    end

    map "/categorys" do
      run Products::API
    end

    map "/orders" do
      run Users::API
    end

    map "/payments" do
      run Products::API
    end
  end
end
