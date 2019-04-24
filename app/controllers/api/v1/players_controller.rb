# frozen_string_literal: true

class Api::V1::PlayersController < ApplicationController
  include Pagination

  def index
    players = PlayerQuery.new(params: params).players
                         .includes(:team)
                         .page(params[:page] || 0)
                         .per(per_page(params[:per_page]))

    render json: {
      data: PlayerSerializer.render_as_hash(players, view: :expanded)
    }.merge(pagination_data(players))
  end

  def show
    player = Player.find_by!(public_id: params[:id])

    render json: PlayerSerializer.render(player, view: :expanded)
  end
end
