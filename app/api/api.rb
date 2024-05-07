class API < Grape::API
  prefix 'api'

  mount Users::API
  mount Products::API
  mount Payments::API
  mount Carts::API
  mount CartItems::API
  mount Orders::API
  mount Categories::API
end
