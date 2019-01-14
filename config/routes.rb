Rails.application.routes.draw do
  namespace :v1 do
    resource :games, only: [:index]
  end
end
