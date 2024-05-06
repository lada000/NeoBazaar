require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module NeoBazaar02
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
    config.api_only = true
  end

  Users::API.compile!
  Products::API.compile!
  Payments::API.compile!
  Orders::API.compile!
  Categorys::API.compile!
  Cart_Items::API.compile!
  Carts::API.compile!
end
