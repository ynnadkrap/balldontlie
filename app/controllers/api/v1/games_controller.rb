class Api::V1::GamesController < ApplicationController
  DEFAULT_PAGE_SIZE = 25

  def index
    games = GameQuery.new(params: params).games
                     .page(params[:page] || 0)
                     .per(params[:per_page] || DEFAULT_PAGE_SIZE)
                     .includes(:player_stats, :home_team, :away_team)

    render json: {
      data: GameSerializer.render_as_hash(games)
    }.merge(pagination_data(games))
  end

  private

  def pagination_data(games)
    {
      total_pages: games.total_pages,
      current_page: games.current_page,
      next_page: games.next_page,
      per_page: games.limit_value,
      total_count: games.total_count
    }
  end
end
