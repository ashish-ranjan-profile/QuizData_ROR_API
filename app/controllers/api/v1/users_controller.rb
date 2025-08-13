class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :update, :destroy ]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    # Always update the logged-in user
    if current_user.update(user_params)
      render json: current_user
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted" }, status: :ok
  end

  def me
    render json: current_user
  end

  private

  def set_user
    # Use current_user if :id is missing or is "update"
    if params[:id].present? && params[:id] != "update"
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def user_params
    params.require(:user).permit(:name, :phone, :image, :email, :password, :password_confirmation)
  end
end
