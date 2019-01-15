class Api::V1::PlayerStatsController < ApplicationController
  DEFAULT_PAGE_SIZE = 25

  def index
    player_stats = PlayerStatQuery.new(params: clean_params).player_stats
                     .page(clean_params[:page] || 0)
                     .per(clean_params[:per_page] || DEFAULT_PAGE_SIZE)
                     .includes(:player, :game, :team)

    render json: {
      data: PlayerStatSerializer.render_as_hash(player_stats, view: :expanded)
    }.merge(pagination_data(player_stats))
  end

  private

  def pagination_data(player_stats)
    {
      meta:{
        total_pages: player_stats.total_pages,
        current_page: player_stats.current_page,
        next_page: player_stats.next_page,
        per_page: player_stats.limit_value,
        total_count: player_stats.total_count
      }
    }
  end

  def clean_params
    @clean_params ||= params.permit(
      :player_ids,
      :game_ids,
      :seasons,
      :dates,
      :page,
      :per_page
    )
  end
end
