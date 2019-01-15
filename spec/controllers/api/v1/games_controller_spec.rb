describe Api::V1::GamesController, type: :controller do
  let!(:games) { create_list(:game, 20) }

  before { get :index, params: { per_page: 10, page: 0 } }

  it 'succeeds' do
    expect(response.status).to eq 200

    res = JSON.parse(response.body).with_indifferent_access
    expect(res[:data].count).to eq 10
    expect(res[:total_pages]).to eq 2
    expect(res[:current_page]).to eq 1
    expect(res[:next_page]).to eq 2
    expect(res[:per_page]).to eq 10
    expect(res[:total_count]).to eq 20
  end
end
