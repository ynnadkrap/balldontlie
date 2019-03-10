Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index, :show]
      resources :players, only: [:index, :show]
      resources :teams, only: [:index, :show]
      get '/stats', to: 'player_stats#index'
      get '/season_averages', to: 'season_averages#index'
    end
  end
end
