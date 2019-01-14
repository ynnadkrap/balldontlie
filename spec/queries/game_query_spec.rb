describe GameQuery do
  context 'when no params are specified' do
    let!(:game_1) { create(:game) }
    let!(:game_2) { create(:game) }
    let!(:game_3) { create(:game) }

    it 'returns all games' do
      res = GameQuery.new.games

      expect(res).to match_array([
        game_1,
        game_2,
        game_3
      ])
    end
  end

  context 'when season is specified' do
    let!(:game_2019) { create(:game, season: 2019) }
    let!(:game_2020) { create(:game, season: 2020) }
    let!(:params) { { season: 2019 } }

    it 'returns the correct games' do
      res = GameQuery.new(params: params).games

      expect(res).to match_array([game_2019])
    end
  end

  context 'when date is specified' do
    let!(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let!(:game_2) { create(:game, date: Date.new(2020, 1, 1)) }
    let!(:params) { { date: '2019-01-01' } }

    it 'returns the correct games' do
      res = GameQuery.new(params: params).games

      expect(res).to match_array([game_1])
    end
  end

  context 'when season and date are both specified' do
    let!(:game_1) { create(:game, date: Date.new(2019, 1, 1), season: 2019) }
    let!(:game_2) { create(:game, date: Date.new(2019, 2, 1), season: 2019) }
    let!(:game_3) { create(:game, date: Date.new(2020, 1, 1), season: 2020) }
    let!(:params) { { date: '2019-01-01', season: 2019 } }

    it 'returns the correct games' do
      res = GameQuery.new(params: params).games

      expect(res).to match_array([game_1])
    end
  end
end
