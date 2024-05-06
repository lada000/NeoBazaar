require 'grape'

module Orders
  class API < Grape::API
    version 'v1', using: :path
    format :json

    resource :orders do
      desc 'Retrieve all orders'
      get do
        Order.all
      end

      desc 'Create a new order'
      post do
        Order.create!
      end

      desc 'Retrieve an order'
      params do
        requires :id, type: Integer, desc: 'Order ID'
      end
      get ':id' do
        Order.find(params[:id])
      end

      desc 'Delete an order'
      params do
        requires :id, type: Integer, desc: 'Order ID'
      end
      delete ':id' do
        Order.find(params[:id]).destroy
      end
    end
  end
end
