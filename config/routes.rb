Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index]
      get '/stats', to: 'player_stats#index'
      resources :players, only: [:index, :show]
    end
  end
end
