class ApplicationController < ActionController::API
  before_action :token_based_auth

  def token_based_auth
    return render json: { status: 'error', message: 'Authentication required' } unless current_user.present?

    current_user
  end

  def current_user
    return false unless token

    OpenStruct.new(jwt_decoded_token[0]['user'])
  end

  private

  def token
    return unless authorization_header

    authorization_header.split.last
  end

  def authorization_header
    @authorization_header ||= request.headers['Authorization']
  end

  def jwt_decoded_token
    JwtAuthService.decode_token(token)
  end

  def not_found
    render json: { status: 'error', message: 'Not found' }
  end

  def render_error(errors)
    render json: { status: 'error', errors: errors }
  end
end
