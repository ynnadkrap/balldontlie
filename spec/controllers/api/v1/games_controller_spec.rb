# frozen_string_literal: true

describe Api::V1::GamesController, type: :controller do
  describe '#index' do
    let!(:team_1) { create(:team) }
    let!(:team_2) { create(:team) }

    let!(:games_team_1) { create_list(:game, 10, home_team: team_1) }
    let!(:games_team_2) { create(:game, home_team: team_2) }

    before { get :index, params: { per_page: 10, page: 0, team_ids: [team_1.public_id] } }

    it 'succeeds' do
      expect(response.status).to eq 200

      res = JSON.parse(response.body).with_indifferent_access
      expect(res[:data].count).to eq 10

      meta = res[:meta]
      expect(meta[:total_pages]).to eq 1
      expect(meta[:current_page]).to eq 1
      expect(meta[:next_page]).to be_nil
      expect(meta[:per_page]).to eq 10
      expect(meta[:total_count]).to eq 10
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
