# frozen_string_literal: true

describe PlayerStatQuery do
  context 'when no params are specified' do
    let!(:player_stats) { create_list(:player_stat, 5) }

    it 'returns all player_stats' do
      res = PlayerStatQuery.new.player_stats

      expect(res.count).to eq 5
    end
  end

  context 'when player_ids are specified' do
    let!(:player_1) { create(:player) }
    let!(:player_2) { create(:player) }
    let!(:player_3) { create(:player) }

    let!(:player_stat_1) { create(:player_stat, player: player_1) }
    let!(:player_stat_2) { create(:player_stat, player: player_1) }
    let!(:player_stat_3) { create(:player_stat, player: player_2) }
    let!(:player_stat_4) { create(:player_stat, player: player_3) }

    let!(:params) { { 'player_ids' => [player_1.public_id, player_2.public_id] } }

    it 'returns stats for the specified players' do
      res = PlayerStatQuery.new(params: params).player_stats

      expect(res).to match_array([
        player_stat_1,
        player_stat_2,
        player_stat_3
      ])
    end
  end

  context 'when game_ids are specified' do
    let!(:game_1) { create(:game) }
    let!(:game_2) { create(:game) }
    let!(:game_3) { create(:game) }

    let!(:player_stat_1) { create(:player_stat, game: game_1) }
    let!(:player_stat_2) { create(:player_stat, game: game_1) }
    let!(:player_stat_3) { create(:player_stat, game: game_2) }
    let!(:player_stat_4) { create(:player_stat, game: game_3) }

    let!(:params) { { 'game_ids' => [game_1.public_id, game_2.public_id] } }

    it 'returns stats for the specified games' do
      res = PlayerStatQuery.new(params: params).player_stats

      expect(res).to match_array([
        player_stat_1,
        player_stat_2,
        player_stat_3
      ])
    end
  end

  context 'when seasons are specified' do
    let!(:game_1) { create(:game, season: 2017) }
    let!(:game_2) { create(:game, season: 2018) }
    let!(:game_3) { create(:game, season: 2019) }

    let!(:player_stat_1) { create(:player_stat, game: game_1) }
    let!(:player_stat_2) { create(:player_stat, game: game_1) }
    let!(:player_stat_3) { create(:player_stat, game: game_2) }
    let!(:player_stat_4) { create(:player_stat, game: game_3) }

    let!(:params) { { 'seasons' => [2017, 2018] } }

    it 'returns stats for the specified seasons' do
      res = PlayerStatQuery.new(params: params).player_stats

      expect(res).to match_array([
        player_stat_1,
        player_stat_2,
        player_stat_3
      ])
    end
  end

  context 'when dates are specified' do
    let!(:game_1) { create(:game, date: '2019-01-02') }
    let!(:game_2) { create(:game, date: '2019-01-03') }
    let!(:game_3) { create(:game, date: '2019-01-04') }

    let!(:player_stat_1) { create(:player_stat, game: game_1) }
    let!(:player_stat_2) { create(:player_stat, game: game_1) }
    let!(:player_stat_3) { create(:player_stat, game: game_2) }
    let!(:player_stat_4) { create(:player_stat, game: game_3) }

    let!(:params) { { 'dates' => %w[2019-01-02 2019-01-03] } }

    it 'returns stats for the specified dates' do
      res = PlayerStatQuery.new(params: params).player_stats

      expect(res).to match_array([
        player_stat_1,
        player_stat_2,
        player_stat_3
      ])
    end
  end

  describe 'postseason' do
    let!(:game_postseason) { create(:game, postseason: true) }
    let!(:game_regular) { create(:game, postseason: false) }

    let!(:player_stat_1) { create(:player_stat, game: game_postseason) }
    let!(:player_stat_2) { create(:player_stat, game: game_regular) }

    context 'when not specified' do
      it 'returns both' do
        res = PlayerStatQuery.new.player_stats

        expect(res).to match_array([player_stat_1, player_stat_2])
      end
    end

    context 'when postseason' do
      it 'returns stats for postseason games' do
        res = PlayerStatQuery.new(params: { 'postseason' => true }).player_stats

        expect(res).to match_array([player_stat_1])
      end
    end

    context 'when not postseason' do
      it 'returns stats for regular season games' do
        res = PlayerStatQuery.new(params: { 'postseason' => false }).player_stats

        expect(res).to match_array([player_stat_2])
      end
    end
  end

  context 'when start_date is specified' do
    let(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let(:game_2) { create(:game, date: Date.new(2018, 1, 1)) }

    let!(:player_stat_1) { create(:player_stat, game: game_1) }
    let!(:player_stat_2) { create(:player_stat, game: game_2) }

    it 'returns stats that occur on or after the date' do
      res = PlayerStatQuery.new(params: { 'start_date' => '2019-01-01' }).player_stats

      expect(res).to match_array([player_stat_1])
    end
  end

  context 'when end_date is specified' do
    let(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let(:game_2) { create(:game, date: Date.new(2018, 1, 1)) }

    let!(:player_stat_1) { create(:player_stat, game: game_1) }
    let!(:player_stat_2) { create(:player_stat, game: game_2) }

    it 'returns stats that occur on or before the date' do
      res = PlayerStatQuery.new(params: { 'end_date' => '2018-01-01' }).player_stats

      expect(res).to match_array([player_stat_2])
    end
  end

  context 'when start and end_date are specified' do
    let(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let(:game_2) { create(:game, date: Date.new(2018, 1, 1)) }
    let(:game_3) { create(:game, date: Date.new(2019, 2, 1)) }
    let(:game_4) { create(:game, date: Date.new(2017, 1, 1)) }

    let!(:player_stat_1) { create(:player_stat, game: game_1) }
    let!(:player_stat_2) { create(:player_stat, game: game_2) }
    let!(:player_stat_3) { create(:player_stat, game: game_3) }
    let!(:player_stat_4) { create(:player_stat, game: game_4) }

    it 'returns stats that occur in the window' do
      res = PlayerStatQuery.new(
        params: { 'start_date' => '2018-01-01', 'end_date' => '2019-01-01' }
      ).player_stats

      expect(res).to match_array([player_stat_1, player_stat_2])
    end
  end

  context 'when multiple param types are specified' do
    let!(:player_1) { create(:player) }
    let!(:player_2) { create(:player) }
    let!(:player_3) { create(:player) }

    let!(:game_1) { create(:game, season: 2019) }
    let!(:game_2) { create(:game, season: 2019) }
    let!(:game_3) { create(:game, season: 2019) }
    let!(:game_4) { create(:game, season: 2018) }

    let!(:player_stat_1) { create(:player_stat, game: game_1, player: player_1) }
    let!(:player_stat_2) { create(:player_stat, game: game_2, player: player_2) }
    let!(:player_stat_3) { create(:player_stat, game: game_3, player: player_3) }
    let!(:player_stat_4) { create(:player_stat, game: game_4, player: player_1) }

    let!(:params) { { 'player_ids' => [player_1.public_id, player_2.public_id], 'seasons' => [2019] } }

    it 'returns the correct stats' do
      res = PlayerStatQuery.new(params: params).player_stats

      expect(res).to match_array([
        player_stat_1,
        player_stat_2
      ])
    end
  end
end
