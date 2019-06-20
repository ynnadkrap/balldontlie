# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      # TODO: send back API token
      render status: 200
    else
      render status: 404
    end
  end
end
