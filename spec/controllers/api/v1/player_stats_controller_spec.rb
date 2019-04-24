# frozen_string_literal: true

describe Api::V1::PlayerStatsController, type: :controller do
  let!(:player_1) { create(:player) }
  let!(:player_2) { create(:player) }

  let!(:stats_player_1) { create_list(:player_stat, 10, player: player_1) }
  let!(:stats_player_2) { create(:player_stat, player: player_2) }

  before { get :index, params: { per_page: 10, page: 0, player_ids: [player_1.public_id] } }

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
