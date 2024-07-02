# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  respond_to :json

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { message: 'Instructions to reset your password have been sent to your email.' }, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /resource/password/verify_token
  def verify_token
    token = params[:token]
    user = User.find_by(reset_password_token: Devise.token_generator.digest(User, :reset_password_token, token))

    if user && user.reset_password_period_valid?
      render json: { message: 'Token is valid.' }, status: :ok
    else
      render json: { error: 'Invalid or expired token.' }, status: :unprocessable_entity
    end
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render json: { message: 'Your password has been changed successfully.' }, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token, :token)
  end
end
