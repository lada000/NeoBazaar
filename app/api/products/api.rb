module Products
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    resource :products do
      desc 'Return all products'
      get do
        ::Product.all
      end

      desc 'Return a product'
      params do
        requires :id, type: Integer, desc: 'Product ID'
      end
      route_param :id do
        get do
          ::Product.find(params[:id])
        end
      end

      desc 'Create a product'
      params do
        requires :name, type: String, desc: 'Product Name'
        requires :price, type: Float, desc: 'Product Price'
      end
      post do
        ::Product.create!(
          name: params[:name],
          price: params[:price]
        )
      end
    end
  end
end
