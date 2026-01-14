class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, jwt_secret, true, algorithm: 'HS256')
      @current_user = User.find(decoded[0]['user_id'])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError, NoMethodError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user = @current_user
  def jwt_secret = Rails.application.credentials.secret_key_base || 'development_secret_key'
  def encode_token(payload) = JWT.encode(payload, jwt_secret, 'HS256')
end
