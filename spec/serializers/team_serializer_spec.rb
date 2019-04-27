# frozen_string_literal: true

describe TeamSerializer do
  let!(:team) { build(:team, public_id: 1) }

  it 'serializes correctly' do
    res = JSON.parse(TeamSerializer.render(team)).with_indifferent_access

    expect(res[:id]).to eq team.public_id
    expect(team[:conference]).to eq team.conference
    expect(team[:division]).to eq team.division
    expect(team[:city]).to eq team.city
    expect(team[:abbreviation]).to eq team.abbreviation
    expect(team[:name]).to eq team.name
    expect(team[:full_name]).to eq team.full_name
  end
end
