module PaymentAPI
  class API < Grape::API
    version 'v1', using: :path
    format :json

    resource :payments do
      desc 'Retrieve all payments'
      get do
        Payment.all
      end

      desc 'Create a new payment'
      post do
        Payment.create!(params)
      end

      desc 'Retrieve a payment'
      params do
        requires :id, type: Integer, desc: 'Payment ID'
      end
      get ':id' do
        Payment.find(params[:id])
      end

      desc 'Delete a payment'
      params do
        requires :id, type: Integer, desc: 'Payment ID'
      end
      delete ':id' do
        Payment.find(params[:id]).destroy
      end
    end
  end
end
