# frozen_string_literal: true

class SessionsController < ApplicationController
  def index
    if session[:user_id]
      user = User.find(session[:user_id])
      render json: { email: user.email }
    else
      head 404
    end
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      # TODO: send back API token
      render json: {}, status: 200
    else
      render json: {}, status: 404
    end
  end

  def destroy
    session[:user_id] = nil

    head 200
  end
end
