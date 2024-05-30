module API
  module AuthHelpers
    def current_user
      @current_user ||= User.find_by(jti: payload['jti']) if payload
    end

    def authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    end

    private

    def payload
      auth_header = headers['Authorization']
      token = auth_header.split(' ').last if auth_header
      JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key, true, algorithm: 'HS256')[0] rescue nil
    end
  end
end
