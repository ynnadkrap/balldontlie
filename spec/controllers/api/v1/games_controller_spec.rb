describe Api::V1::GamesController, type: :controller do
  describe '#index' do
    let!(:games) { create_list(:game, 20) }

    before { get :index, params: { per_page: 10, page: 0 } }

    it 'succeeds' do
      expect(response.status).to eq 200

      res = JSON.parse(response.body).with_indifferent_access
      expect(res[:data].count).to eq 10

      meta = res[:meta]
      expect(meta[:total_pages]).to eq 2
      expect(meta[:current_page]).to eq 1
      expect(meta[:next_page]).to eq 2
      expect(meta[:per_page]).to eq 10
      expect(meta[:total_count]).to eq 20
    end
  end

  describe '#show' do
    let!(:game) { create(:game) }

    before { get :show, params: { id: game.public_id } }

    it 'succeeds' do
      expect(response.status).to eq 200

      res = JSON.parse(response.body).with_indifferent_access

      expect(res[:id]).to eq game.public_id
    end
  end
end
