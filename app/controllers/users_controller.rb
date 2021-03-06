# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {
        users: @users,
      }
    else
      render json: {
        status: 500,
        errors: ["no users found"],
      }
    end
  end

  def show
    @user = User.find(params[:id])

    if @user
      render json: {
        user: @user,
      }
    else
      render json: {
        status: 500,
        errors: ["user not found"],
      }
    end
  end

  def create
    result = SaveUserAndCategories.call(user_params)
    @user = result.user

    if result.success?
      NotificationMailer.send_signup_email(@user).deliver
      user_with_bills = LoginUser.call(user: @user, password: user_params[:password])
      user_result = user_with_bills.user
      session[:user_id] = @user.id
      render json: {
        status: :created,
        user: user_result,
      }
    else
      render json: {
        status: 401,
        errors: result.message,
      }
    end
  end

  def username_exists
    username = User.exists?(username: user_params[:username])
    if username
      head :conflict
    else
      head :ok
    end
  end

  def email_exists
    email = User.exists?(email: user_params[:email])
    if email
      head :conflict
    else
      head :ok
    end
  end

  def update
    @user = User.find_by_id(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user == current_user
      result = UpdateUserAndCategories.call(user_params: user_params, user_to_update: @user)

      render json: {
        status: 200,
        user: result.user,
      }
    else
      render json: {
        status: 500,
        errors: ["Error updating user."],
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :username, :email, :password, :password_confirmation, :postal_code, :sms_notification, :email_notification, :phone_number, categories: [])
  end
end
