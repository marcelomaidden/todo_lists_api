class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  def login

  end



end
