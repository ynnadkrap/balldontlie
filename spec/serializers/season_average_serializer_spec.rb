# frozen_string_literal: true

describe SeasonAverageSerializer do
  let!(:data) do
    [
      {
        'games_played' => 2,
        'player_id' => 14,
        'season' => 2018,
        'min' => '{48:00,24:00}',
        'fgm' => 4.0,
        'fga' => 8.0,
        'fg3m' => 1.0,
        'fg3a' => 2.0,
        'ftm' => 10.0,
        'fta' => 10.0,
        'oreb' => 0.0,
        'dreb' => 2.0,
        'reb' => 2.0,
        'ast' => 5.0,
        'stl' => 1.0,
        'blk' => 0.0,
        'turnover' => 4.0,
        'pf' => 5.0,
        'pts' => 32.0
      }
    ]
  end

  subject { SeasonAverageSerializer.new(data: data).serialize }

  it 'calculates percentages and average minutes played' do
    expect(subject).to eq(
      [
        {
          'games_played' => 2,
          'player_id' => 14,
          'season' => 2018,
          'min' => '36:00',
          'fgm' => 4.0,
          'fga' => 8.0,
          'fg3m' => 1.0,
          'fg3a' => 2.0,
          'ftm' => 10.0,
          'fta' => 10.0,
          'oreb' => 0.0,
          'dreb' => 2.0,
          'reb' => 2.0,
          'ast' => 5.0,
          'stl' => 1.0,
          'blk' => 0.0,
          'turnover' => 4.0,
          'pf' => 5.0,
          'pts' => 32.0,
          'fg_pct' => 0.5,
          'fg3_pct' => 0.5,
          'ft_pct' => 1.0
        }
      ]
    )
  end
end
