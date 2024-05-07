require_relative "boot"
require_relative '../app/api/users/api'
require_relative '../app/api/products/api'
require_relative '../app/api/carts/api'
require_relative '../app/api/cart_items/api'
require_relative '../app/api/categories/api'
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
end
