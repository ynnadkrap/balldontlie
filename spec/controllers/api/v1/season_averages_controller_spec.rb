describe Api::V1::SeasonAveragesController, type: :controller do
  describe '#index' do
    let!(:game) { create(:game, season: 2018) }
    let!(:player) { create(:player) }
    let!(:player_stat) { create(:player_stat, game: game, player: player) }

    before do
      get :index, params: { player_ids: [player.public_id], season: 2018 }
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end
  end
end
