require 'grape'

module Carts
  class API < Grape::API
    version 'v1', using: :path
    format :json

    resource :carts do
      desc 'Retrieve all carts'
      get do
        Cart.all
      end

      desc 'Create a new cart'
      post do
        Cart.create!
      end

      desc 'Retrieve a cart'
      params do
        requires :id, type: Integer, desc: 'Cart ID'
      end
      get ':id' do
        Cart.find(params[:id])
      end

      desc 'Delete a cart'
      params do
        requires :id, type: Integer, desc: 'Cart ID'
      end
      delete ':id' do
        Cart.find(params[:id]).destroy
      end
    end
  end
end
