describe GameSerializer do
  let!(:home_player_stat_1) { instance_double(PlayerStat, pts: 10, team_id: 1) }
  let!(:home_player_stat_2) { instance_double(PlayerStat, pts: 20, team_id: 1) }
  let!(:away_player_stat) { instance_double(PlayerStat, pts: 1, team_id: 2) }

  let!(:game) do
    instance_double(Game,
                    id: 1,
                    date: Date.new(2019, 1, 1),
                    season: 2019,
                    home_team: build(:team_west),
                    away_team: build(:team_east),
                    home_team_id: 1,
                    away_team_id: 2,
                    player_stats: [
                      home_player_stat_1,
                      home_player_stat_2,
                      away_player_stat,
                    ])
  end

  it 'serializes correctly' do
    res = JSON.parse(GameSerializer.render(game)).with_indifferent_access

    expect(res[:id]).to eq 1
    expect(res[:date]).to eq '2019-01-01'
    expect(res[:season]).to eq 2019
    expect(res[:home_team_score]).to eq 30
    expect(res[:away_team_score]).to eq 1
    expect(res[:home_team]).to_not be_nil
    expect(res[:away_team]).to_not be_nil
  end
end
