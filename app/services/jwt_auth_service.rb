class JwtAuthService
  attr_reader :email, :token, :user

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate
    @user = User.find_by(email: email)

    return false unless valid_credentials?

    JWT.encode payload, JwtAuthService.hmac_secret, 'HS256'
  end

  def self.decode_token(token)
    JWT.decode token, JwtAuthService.hmac_secret, true, { algorithm: 'HS256' }
  end

  private

  def payload
    { user: { email: user.email, id: user.id } }
  end

  def valid_credentials?
    return false if user.blank?
    return false unless user.authenticate(@password)

    true
  end

  def self.hmac_secret
    ENV.fetch("hmac_secret", "my_really_strong_secret")
  end
end