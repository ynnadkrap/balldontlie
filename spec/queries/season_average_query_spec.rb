# frozen_string_literal: true

describe SeasonAverageQuery do
  subject { SeasonAverageQuery.new(params: params).averages }

  context 'when no player_ids are passed in' do
    let(:params) do
      { 'season' => 2018 }
    end

    it 'returns an empty array' do
      expect(subject).to be_empty
    end
  end

  context 'when no season is passed in' do
    let!(:game_2018) { create(:game, season: 2018) }
    let!(:game_2017) { create(:game, season: 2017) }

    let!(:player) { create(:player) }
    let!(:player_stat_2018) { create(:player_stat, game: game_2018, player: player) }
    let!(:player_stat_2017) { create(:player_stat, game: game_2017, player: player) }

    let(:params) do
      { 'player_ids' => [player.public_id] }
    end

    it 'defaults to the latest season' do
      expect(subject.size).to eq 1
      expect(subject.first.dig('season')).to eq 2018
    end
  end

  context 'when player_ids and season are specified' do
    let!(:game_1) { create(:game, season: 2016) }
    let!(:game_2) { create(:game, season: 2016) }
    let!(:game_3) { create(:game, season: 2016) }
    let!(:game_4) { create(:game, season: 2016) }

    let!(:player_1) { create(:player, first_name: 'Paul', last_name: 'George') }
    let!(:player_2) { create(:player, first_name: 'Damian', last_name: 'Lillard') }

    let!(:player_stat_1) do
      create(
        :player_stat,
        game: game_1,
        player: player_1,
        min: '34:20',
        fgm: 2,
        fga: 10,
        fg3m: 1,
        fg3a: 4,
        ftm: 9,
        fta: 10,
        oreb: 0,
        dreb: 5,
        reb: 5,
        ast: 4,
        stl: 2,
        blk: 2,
        turnover: 6,
        pf: 2,
        pts: 16
      )
    end
    let!(:player_stat_2) { create(:player_stat, game: game_1, player: player_2) }
    let!(:player_stat_3) do
      create(
        :player_stat,
        game: game_2,
        player: player_1,
        min: '24:33',
        fgm: 4,
        fga: 13,
        fg3m: 2,
        fg3a: 7,
        ftm: 5,
        fta: 5,
        oreb: 1,
        dreb: 3,
        reb: 4,
        ast: 1,
        stl: 1,
        blk: 1,
        turnover: 0,
        pf: 0,
        pts: 17
      )
    end
    let!(:player_stat_4) { create(:player_stat, game: game_2, player: player_2) }
    let!(:player_stat_5) do
      create(:player_stat, game: game_3, player: player_1, min: '0')
    end
    let!(:player_stat_6) do
      create(:player_stat, game: game_4, player: player_1, min: '')
    end

    let(:params) do
      { 'player_ids' => [player_1.public_id, player_2.public_id], 'season' => 2016 }
    end

    it 'returns the correct averages' do
      expect(subject.size).to eq 2
      expect(subject.map { |avg| avg['season'] }.uniq).to eq [2016]

      player_1_avg = subject.find { |avg| avg['player_id'] == player_1.public_id }
      expect(player_1_avg).to eq(
        'season' => 2016,
        'player_id' => player_1.public_id,
        'games_played' => 2,
        'min' => '29:26',
        'fgm' => 3.0,
        'fga' => 11.5,
        'fg_pct' => 0.261,
        'fg3m' => 1.5,
        'fg3a' => 5.5,
        'fg3_pct' => 0.273,
        'ftm' => 7.0,
        'fta' => 7.5,
        'ft_pct' => 0.933,
        'oreb' => 0.5,
        'dreb' => 4.0,
        'reb' => 4.5,
        'ast' => 2.5,
        'stl' => 1.5,
        'blk' => 1.5,
        'turnover' => 3.0,
        'pf' => 1.0,
        'pts' => 16.5
      )
    end
  end
end
