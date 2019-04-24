# frozen_string_literal: true

describe PlayerStatSerializer do
  let!(:game) { build(:game) }
  let!(:player) { build(:player) }
  let!(:team) { build(:team) }
  let!(:player_stat) { build(:player_stat, game: game, player: player, team: team) }

  context 'when expanded' do
    it 'serializers correctly' do
      res = JSON.parse(PlayerStatSerializer.render(player_stat, view: :expanded))

      expect(res['min']).to eq player_stat.min
      expect(res['fgm']).to eq player_stat.fgm
      expect(res['fga']).to eq player_stat.fga
      expect(res['fg_pct']).to eq player_stat.fg_pct
      expect(res['fg3m']).to eq player_stat.fg3m
      expect(res['fg3a']).to eq player_stat.fg3a
      expect(res['fg3_pct']).to eq player_stat.fg3_pct
      expect(res['ftm']).to eq player_stat.ftm
      expect(res['fta']).to eq player_stat.fta
      expect(res['ft_pct']).to eq player_stat.ft_pct
      expect(res['oreb']).to eq player_stat.oreb
      expect(res['dreb']).to eq player_stat.dreb
      expect(res['reb']).to eq player_stat.reb
      expect(res['ast']).to eq player_stat.ast
      expect(res['stl']).to eq player_stat.stl
      expect(res['blk']).to eq player_stat.blk
      expect(res['turnover']).to eq player_stat.turnover
      expect(res['pf']).to eq player_stat.pf
      expect(res['pts']).to eq player_stat.pts

      expect(res['player']).to_not be_nil
      expect(res['game']).to_not be_nil
      expect(res['team']).to_not be_nil
    end
  end
end
