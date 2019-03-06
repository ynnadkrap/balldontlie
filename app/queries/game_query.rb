class GameQuery
  attr_reader :params

  def initialize(params: {})
    @params = {
      'dates' => [],
      'seasons' => [],
      'team_ids' => []
    }.merge(params)
  end

  def games
    scope = Game.all

    scope = dates(scope) if params['dates'].any?
    scope = seasons(scope) if params['seasons'].any?
    scope = team_ids(scope) if params['team_ids'].any?
    scope = postseason(scope) if !params['postseason'].nil?

    scope
  end

  private

  def dates(scope)
    scope.where(date: params['dates'])
  end

  def seasons(scope)
    scope.where(season: params['seasons'])
  end

  def team_ids(scope)
    scope.joins(:home_team, :visitor_team).where(
      'teams.public_id in (?) or visitor_teams_games.public_id in (?)',
      params['team_ids'],
      params['team_ids']
    )
  end

  def postseason(scope)
    scope.where(postseason: params['postseason'])
  end
end
