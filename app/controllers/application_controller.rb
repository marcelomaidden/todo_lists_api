class ApplicationController < ActionController::API
  before_action :token_based_auth

  def token_based_auth
    unless current_user.present?
      return render json: { status: "error", message: "Authentication required" }
    end

    current_user
  end

  def current_user
    return false unless token
    OpenStruct.new(jwt_decoded_token[0]["user"])
  end

  private

  def token
    request.headers['Authorization'].split.last
  end

  def jwt_decoded_token
    JwtAuthService.decode_token(token)
  end
end
