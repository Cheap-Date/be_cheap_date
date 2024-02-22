class Api::V1::UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end