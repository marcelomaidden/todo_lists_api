class UsersController < ApplicationController
  skip_before_action :token_based_auth, only: %i[create login]

  def show
    @user = User.find(params[:id])

    if @user.id != current_user.id
      render json: { status: "error",  message: "Not allowed user" }
    else
      render json: @user
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { token: jwt_token }
    else
      render json: @user.errors
    end

  rescue ActionController::ParameterMissing
    render json: { status: "error", message: "Parameter user required" }
  end

  def login

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def jwt_token
    service = JwtAuthService.new(user_params[:email], user_params[:password])

    service.authenticate
  end
end
