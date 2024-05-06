require 'grape'

module Users
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    resource :users do
      desc 'Return all users'
      get do
        ::User.all
      end

      desc 'Return a user'
      params do
        requires :id, type: Integer, desc: 'User ID'
      end
      route_param :id do
        get do
          ::User.find(params[:id])
        end
      end

      desc 'Create a user'
      params do
        requires :username, type: String, desc: 'Username'
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
      end
      post do
        ::User.create!(
          username: params[:username],
          email: params[:email],
          password: params[:password]
        )
      end
    end
  end
end
