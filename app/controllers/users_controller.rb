# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    # TODO: create API token
    user = User.create!(create_params)
    session[:user_id] = user.id

    # TODO: send back API token
    render status: 200
  end

  private

  def create_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation)
  end
end
