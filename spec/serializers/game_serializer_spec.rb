# frozen_string_literal: true

describe GameSerializer do
  let!(:home_player_stat_1) { instance_double(PlayerStat, pts: 10, team_id: 1) }
  let!(:home_player_stat_2) { instance_double(PlayerStat, pts: 20, team_id: 1) }
  let!(:home_player_stat_3) { instance_double(PlayerStat, pts: nil, team_id: 1) }
  let!(:away_player_stat) { instance_double(PlayerStat, pts: 1, team_id: 2) }

  let!(:game) do
    instance_double(Game,
                    id: 1,
                    public_id: 99,
                    date: Date.new(2019, 1, 1),
                    season: 2019,
                    home_team: build(:team_west),
                    visitor_team: build(:team_east),
                    home_team_id: 1,
                    status: 'Final',
                    period: 4,
                    time: ' ',
                    visitor_team_id: 2,
                    player_stats: [
                      home_player_stat_1,
                      home_player_stat_2,
                      home_player_stat_3,
                      away_player_stat
                    ],
                    postseason: false)
  end

  context 'when expanded' do
    it 'serializes correctly' do
      res = JSON.parse(GameSerializer.render(game, view: :expanded)).with_indifferent_access

      expect(res[:id]).to eq game.public_id
      expect(res[:date]).to eq '2019-01-01'
      expect(res[:season]).to eq 2019
      expect(res[:home_team_score]).to eq 30
      expect(res[:visitor_team_score]).to eq 1
      expect(res[:home_team]).to_not be_nil
      expect(res[:visitor_team]).to_not be_nil
      expect(res[:home_team_id]).to be_nil
      expect(res[:visitor_team_id]).to be_nil
      expect(res[:status]).to eq 'Final'
      expect(res[:period]).to eq 4
      expect(res[:time]).to eq ' '
      expect(res[:postseason]).to eq false
    end
  end

  context 'when slim' do
    it 'serializes correctly' do
      res = JSON.parse(GameSerializer.render(game, view: :slim)).with_indifferent_access

      expect(res[:id]).to eq game.public_id
      expect(res[:date]).to eq '2019-01-01'
      expect(res[:season]).to eq 2019
      expect(res[:home_team_score]).to eq 30
      expect(res[:visitor_team_score]).to eq 1
      expect(res[:home_team]).to be_nil
      expect(res[:visitor_team]).to be_nil
      expect(res[:home_team_id]).to eq game.home_team.public_id
      expect(res[:visitor_team_id]).to eq game.visitor_team.public_id
      expect(res[:status]).to eq 'Final'
      expect(res[:period]).to eq 4
      expect(res[:time]).to eq ' '
      expect(res[:postseason]).to eq false
    end
  end

  context 'when game has no player_stats' do
    let!(:game) { create(:game) }

    it 'returns 0 for both scores' do
      res = JSON.parse(GameSerializer.render(game, view: :slim)).with_indifferent_access

      expect(res[:home_team_score]).to eq 0
      expect(res[:visitor_team_score]).to eq 0
    end
  end
end
