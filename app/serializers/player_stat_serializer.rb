class PlayerStatSerializer < Blueprinter::Base
  identifier :id do |object|
    object.public_id
  end

  fields :min,
    :fgm,
    :fga,
    :fg_pct,
    :fg3m,
    :fg3a,
    :fg3_pct,
    :ftm,
    :fta,
    :ft_pct,
    :oreb,
    :dreb,
    :reb,
    :ast,
    :stl,
    :blk,
    :turnover,
    :pf,
    :pts

  view :expanded do
    association :player, blueprint: PlayerSerializer, view: :slim
    association :game, blueprint: GameSerializer, view: :slim
    association :team, blueprint: TeamSerializer
  end
end
