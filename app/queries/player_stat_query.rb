# frozen_string_literal: true

class PlayerStatQuery
  attr_reader :params

  def initialize(params: {})
    @params = {
      'player_ids' => [],
      'game_ids' => [],
      'seasons' => [],
      'dates' => []
    }.merge(params)
  end

  def player_stats
    scope = PlayerStat.all

    scope = player_ids(scope) unless params['player_ids'].empty?
    scope = game_ids(scope) unless params['game_ids'].empty?
    scope = seasons(scope) unless params['seasons'].empty?
    scope = dates(scope) unless params['dates'].empty?
    scope = postseason(scope) unless params['postseason'].nil?
    scope = start_date(scope) if params['start_date']
    scope = end_date(scope) if params['end_date']

    scope
  end

  private

  def player_ids(scope)
    scope.joins(:player).where(players: { public_id: params['player_ids'] })
  end

  def game_ids(scope)
    scope.joins(:game).where(games: { public_id: params['game_ids'] })
  end

  def seasons(scope)
    scope.joins(:game).where(games: { season: params['seasons'] })
  end

  def dates(scope)
    scope.joins(:game).where(games: { date: params['dates'] })
  end

  def postseason(scope)
    scope.joins(:game).where(games: { postseason: params['postseason'] })
  end

  def start_date(scope)
    scope.joins(:game).where('games.date >= ?', params['start_date'])
  end

  def end_date(scope)
    scope.joins(:game).where('games.date <= ?', params['end_date'])
  end
end
