# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user
      user_with_bills = LoginUser.call(user: user, password: session_params[:password])
      session[:user_id] = user.id
      render json: {
        status: :created,
        user: user_with_bills.user
      }
    else
      render json: {
        status: 401,
        errors: ['Invalid username or password.']
      }
    end
  end

  def is_logged_in?
    if logged_in? && current_user
      render json: {
        logged_in: true,
        user: current_user
      }
    else
      render json: {
        logged_in: false,
        message: 'no such user'
      }
    end
  end

  def destroy
    # Remove after development
    puts current_user.inspect
    logout!
    # Remove after development
    puts current_user.inspect
    render json: {
      status: 200,
      logged_out: true
    }
  end

  private

  def session_params
    params.require(:user).permit(:username, :email, :password)
  end
end
