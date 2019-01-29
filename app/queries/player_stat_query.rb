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

    scope = player_ids(scope) if !params['player_ids'].empty?
    scope = game_ids(scope) if !params['game_ids'].empty?
    scope = seasons(scope) if !params['seasons'].empty?
    scope = dates(scope) if !params['dates'].empty?

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
end
