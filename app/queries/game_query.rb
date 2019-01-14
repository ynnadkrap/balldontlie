class GameQuery
  attr_reader :params

  DEFAULT_PAGE_SIZE = 50

  def initialize(params: {})
    @params = params
  end

  def games
    scope = Game.all

    scope = date(scope) if params[:date]
    scope = season(scope) if params[:season]
    scope = paginate(scope)

    scope
  end

  private

  def date(scope)
    scope.where(date: params[:date])
  end

  def season(scope)
    scope.where(season: params[:season])
  end

  def paginate(scope)
    scope
      .page(params[:page] || 0)
      .per(params[:per_page] || DEFAULT_PAGE_SIZE)
  end
end
