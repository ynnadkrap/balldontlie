describe Api::V1::PlayerStatsController, type: :controller do
  let!(:games) { create_list(:player_stat, 11) }

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
    expect(meta[:total_count]).to eq 11
  end
end
