require 'grape'

module Products
  class API < Grape::API
    resource :products do
      desc 'Return all products'
      get do
        Product.all
      end

      desc 'Return a product'
      params do
        requires :id, type: Integer, desc: 'Product ID'
      end
      route_param :id do
        get do
          Product.find(params[:id])
        end
      end

      desc 'Create a product'
      params do
        requires :title, type: String
        requires :description, type: String
        requires :price, type: Float
        requires :currency, type: String
        requires :status, type: String
        requires :category_id, type: Integer
        optional :user_id, type: Integer
      end
      post do
        Product.create!({
          title: params[:title],
          description: params[:description],
          price: params[:price],
          currency: params[:currency],
          status: params[:status],
          category_id: params[:category_id],
          user_id: params[:user_id]
        })
      end

      desc 'Update a product'
      params do
        requires :id, type: Integer
        requires :title, type: String
        requires :description, type: String
        requires :price, type: Float
        requires :currency, type: String
        requires :status, type: String
        requires :category_id, type: Integer
        optional :user_id, type: Integer
      end
      put ':id' do
        product = Product.find(params[:id])
        product.update({
          title: params[:title],
          description: params[:description],
          price: params[:price],
          currency: params[:currency],
          status: params[:status],
          category_id: params[:category_id],
          user_id: params[:user_id]
        })
        product
      end

      desc 'Delete a product'
      params do
        requires :id, type: Integer
      end
      delete ':id' do
        Product.find(params[:id]).destroy
      end

      desc 'Return products for a specific user'
      params do
        requires :user_id, type: Integer, desc: 'User ID'
      end
      get 'user_products' do
        Product.where(user_id: params[:user_id])
      end
    end
  end
end
