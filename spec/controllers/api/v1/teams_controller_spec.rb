describe Api::V1::TeamsController, type: :controller do
  describe '#index' do
    let!(:teams) { create_list(:team, 10) }

    before { get :index }

    it 'succeeds' do
      expect(response.status).to eq 200

      res = JSON.parse(response.body).with_indifferent_access
      expect(res[:data].length).to eq 10
    end
  end

  describe '#show' do
    let!(:team) { create(:team) }

    before { get :show, params: { id: team.public_id } }

    it 'succeeds' do
      expect(response.status).to eq 200

      res = JSON.parse(response.body).with_indifferent_access
      expect(res[:public_id]).to eq team.public_id
    end
  end
end
