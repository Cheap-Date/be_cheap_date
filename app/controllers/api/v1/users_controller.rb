class Api::V1::UsersController < ApplicationController

  def index
    users = User.all
    render json: UserSerializer.new(users)
  end

  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user)
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unauthorized
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end