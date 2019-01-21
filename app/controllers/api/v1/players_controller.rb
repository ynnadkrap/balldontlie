class Api::V1::PlayersController < ApplicationController
  include Pagination

  def index
    players = PlayerQuery.new(params: params).players
      .includes(:team)
      .page(params[:page] || 0)
      .per(params[:per_page] || DEFAULT_PAGE_SIZE)

    render json: {
      data: PlayerSerializer.render_as_hash(players, view: :expanded)
    }.merge(pagination_data(players))
  end
end
