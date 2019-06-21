# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.create!(create_params)
    session[:user_id] = user.id

    render json: { token: user.token }
  end

  private

  def create_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation)
  end
end
