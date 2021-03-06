class ApplicationController < ActionController::API
  before_action :token_based_auth

  def token_based_auth
    return render_error('Authentication required') unless current_user.present?

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
    render status: 404, json: { message: 'Not found' }
  end

  def render_error(errors)
    render status: 403, json: { errors: errors }
  end

  def render_success(params)
    render status: 200, json: params
  end

  def render_bad_request(message)
    render status: 400, json: { error: message }
  end
end
