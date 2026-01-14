class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:register, :login]

  def register
    user = User.new(params.permit(:email, :password, :password_confirmation))
    if user.save
      render json: { token: encode_token({ user_id: user.id, exp: 24.hours.from_now.to_i }), user: { id: user.id, email: user.email } }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { token: encode_token({ user_id: user.id, exp: 24.hours.from_now.to_i }), user: { id: user.id, email: user.email } }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def me
    render json: { user: { id: current_user.id, email: current_user.email } }
  end
end
