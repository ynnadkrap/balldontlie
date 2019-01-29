class GameSerializer < Blueprinter::Base
  identifier :id do |object|
    object.public_id
  end

  fields :date, :season

  field :home_team_score do |game|
    game.player_stats.reduce(0) do |acc, stat|
      if stat.team_id == game.home_team_id
        acc + stat.pts.to_i
      else
        acc
      end
    end
  end

  field :visitor_team_score do |game|
    game.player_stats.reduce(0) do |acc, stat|
      if stat.team_id == game.visitor_team_id
        acc + stat.pts.to_i
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
    field :home_team_id do |object|
      object.home_team.public_id
    end

    field :visitor_team_id do |object|
      object.visitor_team.public_id
    end
  end
end
