class UsersController < ApplicationController
  skip_before_action :token_based_auth, only: %i[create login]
  before_action :validate_user, only: %i[show update]

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { token: jwt_token }
    else
      render json: @user.errors
    end
  rescue ActionController::ParameterMissing
    render_error('Parameter user required')
  end

  def login
    return render json: { token: jwt_token } if jwt_token

    render_error('Invalid credentials')
  rescue ActionController::ParameterMissing
    render_error('Parameter user required')
  end

  private

  def validate_user
    @user = User.find(params[:id])

    return render_error('Unauthorized') if @user.id != current_user.id
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def jwt_token
    service = JwtAuthService.new(user_params[:email], user_params[:password])

    service.authenticate
  end
end
