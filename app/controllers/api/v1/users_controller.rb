class Api::V1::UsersController < ApplicationController

  # GET /api/v1/users
  def index
    users = User.all
    render json: UserSerializer.new(users)
  end

  # GET /api/v1/find_by_email
  def user_by_email
    user_email = params[:email]
    user = User.find_by(email: user_email)
    if user == nil
      render json: { error: 'This email is not associated with an account', status: 404 }, status: :not_found
    elsif user.valid_password?(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { error: 'Sorry, your credentials are bad', status: 401 }, status: :unauthorized
    end
  end

  # GET /api/v1/users/1
  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user)
  end

  # POST /api/v1/users
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unauthorized
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    user = User.find(params[:id])
    user.destroy!
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
