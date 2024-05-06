require 'grape'

module CartItems
  class API < Grape::API
    version 'v1', using: :path
    format :json

    resource :cart_items do
      desc 'Retrieve all cart items'
      get do
        CartItem.all
      end

      desc 'Create a new cart item'
      params do
        requires :product_id, type: Integer, desc: 'Product ID'
        requires :quantity, type: Integer, desc: 'Quantity'
      end
      post do
        CartItem.create!(product_id: params[:product_id], quantity: params[:quantity])
      end

      desc 'Update a cart item'
      params do
        requires :id, type: Integer, desc: 'Cart Item ID'
        requires :quantity, type: Integer, desc: 'Quantity'
      end
      put ':id' do
        cart_item = CartItem.find(params[:id])
        cart_item.update(quantity: params[:quantity])
        cart_item
      end

      desc 'Delete a cart item'
      params do
        requires :id, type: Integer, desc: 'Cart Item ID'
      end
      delete ':id' do
        CartItem.find(params[:id]).destroy
      end
    end
  end
end
