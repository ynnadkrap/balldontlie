# frozen_string_literal: true

class PlayerQuery
  attr_reader :params

  def initialize(params: {})
    @params = params
  end

  def players
    scope = Player.all

    scope = search(scope) if params[:search]

    scope
  end

  private

  def search(scope)
    scope.where("concat(first_name, ' ', last_name) ilike ?", "%#{params[:search]}%")
  end
end
