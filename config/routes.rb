# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: %i[index show]
      resources :players, only: %i[index show]
      resources :teams, only: %i[index show]
      get '/stats', to: 'player_stats#index'
      get '/season_averages', to: 'season_averages#index'
    end
  end

  get '/docs', to: redirect('index.html')
  get '/test', to: redirect('https://app.balldontlie.io')
  root to: 'main#index'
end
