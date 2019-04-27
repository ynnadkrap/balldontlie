# frozen_string_literal: true

FactoryBot.define do
  factory :player_stat do
    id
    public_id { generate(:id) }
    game
    team
    player
    min { '48:00' }
    fgm { 4 }
    fga { 8 }
    fg_pct { 0.50 }
    fg3m { 1 }
    fg3a { 2 }
    fg3_pct { 0.50 }
    ftm { 10 }
    fta { 10 }
    ft_pct { 1 }
    oreb { 0 }
    dreb { 2 }
    reb { 2 }
    ast { 5 }
    stl { 1 }
    blk { 0 }
    turnover { 4 }
    pf { 5 }
    pts { 32 }
  end
end
