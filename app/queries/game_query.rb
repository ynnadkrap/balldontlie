class GameQuery
  attr_reader :params

  def initialize(params: {})
    @params = params
  end

  def games
    scope = Game.all

    scope = date(scope) if params[:date]
    scope = season(scope) if params[:season]

    scope
  end

  private

  def date(scope)
    scope.where(date: params[:date])
  end

  def season(scope)
    scope.where(season: params[:season])
  end
end
