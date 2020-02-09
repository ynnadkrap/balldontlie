# frozen_string_literal: true

class SeasonAverageQuery
  attr_reader :params

  def initialize(params: {})
    @params = { 'player_ids' => [] }.merge(params)
    @params['season'] = params['season'] || Game.order(season: :desc).take.season
  end

  def averages
    return [] unless params['player_ids'].any?

    SeasonAverageSerializer.new(data: data).serialize
  end

  private

  def data
    season = params['season']
    player_ids = "{#{params['player_ids'].join(',')}}"

    ActiveRecord::Base.connection.exec_query <<~SQL, 'SQL', [[nil, season], [nil, player_ids]]
      SELECT
        count(*) as games_played,
        players.public_id as player_id,
        season,
        array_agg(min) as min,
        avg(fgm)::float as fgm,
        avg(fga)::float as fga,
        avg(fg3m)::float as fg3m,
        avg(fg3a)::float as fg3a,
        avg(ftm)::float as ftm,
        avg(fta)::float as fta,
        round(avg(oreb), 2)::float as oreb,
        round(avg(dreb), 2)::float as dreb,
        round(avg(reb), 2)::float as reb,
        round(avg(ast), 2)::float as ast,
        round(avg(stl), 2)::float as stl,
        round(avg(blk), 2)::float as blk,
        round(avg(turnover), 2)::float as turnover,
        round(avg(pf), 2)::float as pf,
        round(avg(pts), 2)::float as pts
      FROM player_stats
      JOIN games ON games.id = player_stats.game_id
      JOIN players on players.id = player_stats.player_id
      WHERE season = $1
        AND players.public_id = ANY($2::int[])
        AND min IS NOT NULL
        AND min != '0'
        AND min != ''
        AND postseason = false
      GROUP BY players.public_id, season
    SQL
  end
end
