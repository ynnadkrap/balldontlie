# frozen_string_literal: true

class Api::V1::PlayerStatsController < ApplicationController
  include Pagination

  def index
    player_stats = PlayerStatQuery.new(params: clean_params).player_stats
                                  .page(clean_params[:page] || 0)
                                  .per(per_page(clean_params[:per_page]))
                                  .includes({ player: :team }, { game: %i[player_stats home_team visitor_team] }, :team)

    render json: {
      data: PlayerStatSerializer.render_as_hash(player_stats, view: :expanded)
    }.merge(pagination_data(player_stats))
  end

  private

  def clean_params
    @clean_params ||= params.permit(
      :page,
      :per_page,
      :postseason,
      :start_date,
      :end_date,
      player_ids: [],
      game_ids: [],
      seasons: [],
      dates: []
    )
  end
end
