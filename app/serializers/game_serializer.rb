class GameSerializer < Blueprinter::Base
  identifier :id

  fields :date, :season

  field :home_team_score do |game|
    game.player_stats.reduce(0) do |acc, stat|
      if stat.team_id == game.home_team_id
        acc + stat.pts
      else
        acc
      end
    end
  end

  field :visitor_team_score do |game|
    game.player_stats.reduce(0) do |acc, stat|
      if stat.team_id == game.visitor_team_id
        acc + stat.pts
      else
        acc
      end
    end
  end

  view :expanded do
    association :home_team, blueprint: TeamSerializer
    association :visitor_team, blueprint: TeamSerializer
  end

  view :slim do
    fields :home_team_id, :visitor_team_id
  end
end
