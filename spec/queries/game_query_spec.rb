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
    let!(:game_2021) { create(:game, season: 2021) }
    let!(:params) { { 'seasons' => [2019, 2020] } }

    it 'returns the correct games' do
      res = GameQuery.new(params: params).games

      expect(res).to match_array([game_2019, game_2020])
    end
  end

  context 'when date is specified' do
    let!(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let!(:game_2) { create(:game, date: Date.new(2020, 1, 1)) }
    let!(:game_3) { create(:game, date: Date.new(2021, 1, 1)) }
    let!(:params) { { 'dates' => ['2019-01-01', '2020-1-1'] } }

    it 'returns the correct games' do
      res = GameQuery.new(params: params).games

      expect(res).to match_array([game_1, game_2])
    end
  end

  context 'when teams are specified' do
    let!(:team_1) { create(:team) }
    let!(:team_2) { create(:team) }
    let!(:team_3) { create(:team) }

    let!(:game_1) { create(:game, home_team: team_1) }
    let!(:game_2) { create(:game, visitor_team: team_2) }
    let!(:game_3) { create(:game, home_team: team_3) }

    let!(:params) { { 'team_ids' => [team_1.public_id, team_2.public_id] } }

    it 'returns the correct games' do
      res = GameQuery.new(params: params).games

      expect(res).to match_array([game_1, game_2])
    end
  end

  describe 'postseason' do
    let!(:game_postseason) { create(:game, postseason: true) }
    let!(:game_regular) { create(:game, postseason: false) }

    context 'when not specified' do
      it 'returns both' do
        res = GameQuery.new.games

        expect(res).to match_array([game_postseason, game_regular])
      end
    end

    context 'when postseason' do
      it 'returns postseason games' do
        res = GameQuery.new(params: { 'postseason' => true }).games

        expect(res).to match_array([game_postseason])
      end
    end

    context 'when not postseason' do
      it 'returns regular season games' do
        res = GameQuery.new(params: { 'postseason' => false }).games

        expect(res).to match_array([game_regular])
      end
    end
  end

  context 'when start_date is specified' do
    let(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let(:game_2) { create(:game, date: Date.new(2018, 1, 1)) }

    it 'returns games that occur on or after the date' do
      res = GameQuery.new(params: { 'start_date' => '2019-01-01' }).games

      expect(res).to match_array([game_1])
    end
  end

  context 'when end_date is specified' do
    let(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let(:game_2) { create(:game, date: Date.new(2018, 1, 1)) }

    it 'returns games that occur on or before the date' do
      res = GameQuery.new(params: { 'end_date' => '2018-01-01' }).games

      expect(res).to match_array([game_2])
    end
  end

  context 'when start and end_date are specified' do
    let(:game_1) { create(:game, date: Date.new(2019, 1, 1)) }
    let(:game_2) { create(:game, date: Date.new(2018, 1, 1)) }
    let(:game_3) { create(:game, date: Date.new(2019, 2, 1)) }
    let(:game_4) { create(:game, date: Date.new(2017, 1, 1)) }

    it 'returns games that occur in the window' do
      res = GameQuery.new(params: { 'start_date' => '2018-01-01', 'end_date' => '2019-01-01' }).games

      expect(res).to match_array([game_1, game_2])
    end
  end

  context 'when season and teams are both specified' do
    let!(:team_1) { create(:team) }
    let!(:team_2) { create(:team) }
    let!(:team_3) { create(:team) }

    let!(:game_1) { create(:game, date: Date.new(2019, 1, 1), home_team: team_1) }
    let!(:game_2) { create(:game, date: Date.new(2019, 1, 1), visitor_team: team_2) }
    let!(:game_3) { create(:game, date: Date.new(2019, 1, 1), home_team: team_3) }

    let!(:params) { { 'dates' => ['2019-1-1'], 'team_ids' => [team_1.public_id, team_2.public_id] } }

    it 'returns the correct games' do
      res = GameQuery.new(params: params).games

      expect(res).to match_array([game_1, game_2])
    end
  end
end
