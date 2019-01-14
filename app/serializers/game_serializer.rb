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

  field :away_team_score do |game|
    game.player_stats.reduce(0) do |acc, stat|
      if stat.team_id == game.away_team_id
        acc + stat.pts
      else
        acc
      end
    end
  end

  association :home_team, blueprint: TeamSerializer
  association :away_team, blueprint: TeamSerializer
end
