class Api::V1::GamesController < ApplicationController
  include Pagination

  def index
    games = GameQuery.new(params: clean_params).games
                     .page(clean_params[:page] || 0)
                     .per(clean_params[:per_page] || DEFAULT_PAGE_SIZE)
                     .includes(:player_stats, :home_team, :visitor_team)

    render json: {
      data: GameSerializer.render_as_hash(games, view: :expanded)
    }.merge(pagination_data(games))
  end

  def show
    game = Game.find_by!(public_id: params[:id])

    render json: GameSerializer.render(game, view: :expanded)
  end

  private

  def clean_params
    @clean_params ||= params.permit(
      :page,
      :per_page,
      :postseason,
      dates: [],
      seasons: [],
      team_ids: []
    )
  end
end
