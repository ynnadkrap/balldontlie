# frozen_string_literal: true

module RequestHelper
  def login(user)
    request.session[:user_id] = user.id
  end
end
