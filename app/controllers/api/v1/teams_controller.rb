class Api::V1::TeamsController < ApplicationController
  include Pagination

  def index
    teams = Team.all
      .page(params[:page] || 0)
      .per(params[:per_page] || 30)

    render json: {
      data: TeamSerializer.render_as_hash(teams)
    }.merge(pagination_data(teams))
  end

  def show
    team = Team.find_by!(public_id: params[:id])

    render json: TeamSerializer.render(team)
  end
end
