# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  respond_to :json

  # POST /resource/password
  def create
    logger.info "Received parameters: #{params.inspect}"

    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { message: 'Instructions to reset your password have been sent to your email.' }, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    logger.error "Error occurred while sending reset password instructions: #{e.message}"
    render json: { error: 'An error occurred while processing your request. Please try again later.' }, status: :internal_server_error
  end

  # PUT /resource/password
  def update
    logger.info "Received parameters: #{params.inspect}"

    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render json: { message: 'Your password has been changed successfully.' }, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    logger.error "Error occurred while resetting password: #{e.message}"
    render json: { error: 'An error occurred while processing your request. Please try again later.' }, status: :internal_server_error
  end

  private

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
end
