Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index]
      get '/stats', to: 'player_stats#index'
    end
  end
end
