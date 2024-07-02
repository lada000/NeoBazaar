require 'grape'

module Products
  class API < Grape::API
    version 'v1', using: :path

    helpers do
      def current_user
        @current_user ||= User.find_by(jti: payload['jti']) if payload
      end

      # def authenticate!
      #   error!('Unauthorized. Invalid or expired token.', 401) unless current_user
      # end

      private

      def payload
        auth_header = headers['authorization']
        token = auth_header.split(' ').last if auth_header
        JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key, true, algorithm: 'HS256')[0] rescue nil
      end
    end

    # before { authenticate! }

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
        requires :currency, type: String, values: ['USD']
        requires :status, type: String, values: ['Draft', 'Published', 'Deactivated']
        requires :category_id, type: Integer
        requires :delivery_time, type: String, values: ['Instantly', '1 hour', '6 hours', '12 hours', '24 hours']
      end
      post do
        Product.create!({
          title: params[:title],
          description: params[:description],
          price: params[:price],
          currency: params[:currency],
          status: params[:status],
          category_id: params[:category_id],
          user_id: current_user.id,
          delivery_time: params[:delivery_time],
        })

        # вернуть нормальный ответ (200 OK или описание продукта )
      end

      desc 'Update a product'
      params do
        requires :id, type: Integer
        requires :title, type: String
        requires :description, type: String
        requires :price, type: Float
        requires :currency, type: String, values: ['USD']
        requires :status, type: String, values: ['Draft', 'Published', 'Deactivated']
        requires :category_id, type: Integer
        requires :user_id, type: Integer
        requires :delivery_time, type: String, values: ['Instantly', '1 hour', '6 hours', '12 hours', '24 hours']
      end
      put ':id' do
        product = Product.find(params[:id])
        product.update!({
          title: params[:title],
          description: params[:description],
          price: params[:price],
          currency: params[:currency],
          status: params[:status],
          category_id: params[:category_id],
          user_id: params[:user_id],
          delivery_time: params[:delivery_time]
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
