require 'grape'

module Users
  class API < Grape::API
    version 'v1', using: :path
    format :json

    helpers do
      def current_user
        @current_user ||= User.find_by(jti: payload['jti']) if payload
      end

      def authenticate!
        error!('Unauthorized. Invalid or expired token.', 401) unless current_user
      end

      private

      def payload
        auth_header = headers['authorization']
        token = auth_header.split(' ').last if auth_header
        JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key, true, algorithm: 'HS256')[0] rescue nil
      end
    end

    before { authenticate! }

    resource :users do
      desc 'Return all users'
      get do
        User.all
      end

      desc 'Return a user'
      params do
        requires :id, type: Integer, desc: 'User ID'
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end

      desc 'Create a user'
      params do
        requires :username, type: String, desc: 'Username'
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
      end
      post do
        user = User.new(
          username: params[:username],
          email: params[:email],
          password: params[:password]
        )

        attributes = %w[id username email]
        user.save ? user.attributes.slice(*attributes) : { errors: user.errors }
      end
    end
  end
end
