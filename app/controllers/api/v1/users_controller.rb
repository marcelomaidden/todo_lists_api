class Api::V1::UsersController < ApplicationController
  skip_before_action :token_based_auth, only: %i[create login]
  before_action :validate_user, only: %i[show update]

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render_success(token: jwt_token)
    else
      render_bad_request(@user.errors)
    end
  rescue ActionController::ParameterMissing
    render_bad_request('Parameter user required')
  end

  def login
    return render_success(token: jwt_token) if jwt_token

    render_bad_request('Invalid credentials')
  rescue ActionController::ParameterMissing
    render_bad_request('Parameter user required')
  end

  private

  def validate_user
    @user = User.find(params[:id])

    return render_bad_request('Unauthorized') if @user.id != current_user.id
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def jwt_token
    service = JwtAuthService.new(user_params[:email], user_params[:password])

    service.authenticate
  end
end
