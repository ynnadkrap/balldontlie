describe PlayerQuery do
  context 'when no params specified' do
    let!(:player_1) { create(:player) }
    let!(:player_2) { create(:player) }

    it 'returns all players' do
      res = PlayerQuery.new.players

      expect(res).to match_array([player_1, player_2])
    end
  end

  context 'when searching' do
    let!(:player_1) { create(:player, first_name: 'LeBron', last_name: 'James') }
    let!(:player_2) { create(:player, first_name: 'Steph', last_name: 'Curry') }
    let!(:player_3) { create(:player, first_name: 'James', last_name: 'Harden') }

    let!(:params) { { search: 'james' } }

    it 'returns the correct players' do
      res = PlayerQuery.new(params: params).players

      expect(res).to match_array([player_1, player_3])
    end
  end
end
