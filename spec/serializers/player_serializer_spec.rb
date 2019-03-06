describe PlayerSerializer do
  context 'when expanded' do
    let!(:team) { Team.new }
    let!(:player) { build(:player, team: team) }

    it 'serializes correctly' do
      res = JSON.parse(PlayerSerializer.render(player, view: :expanded)).with_indifferent_access

      expect(res[:id]).to eq player.public_id
      expect(res[:first_name]).to eq player.first_name
      expect(res[:last_name]).to eq player.last_name
      expect(res[:position]).to eq player.position
      expect(res[:height_feet]).to eq player.height_feet
      expect(res[:height_inches]).to eq player.height_inches
      expect(res[:weight_pounds]).to eq player.weight_pounds
      expect(res[:team]).to_not be_nil
      expect(res[:team_id]).to be_nil
    end
  end

  context 'when slim' do
    let!(:team) { Team.new(public_id: 3) }
    let!(:player) { build(:player, team: team) }

    it 'serializes correctly' do
      res = JSON.parse(PlayerSerializer.render(player, view: :slim)).with_indifferent_access

      expect(res[:id]).to eq player.public_id
      expect(res[:first_name]).to eq player.first_name
      expect(res[:last_name]).to eq player.last_name
      expect(res[:position]).to eq player.position
      expect(res[:height_feet]).to eq player.height_feet
      expect(res[:height_inches]).to eq player.height_inches
      expect(res[:weight_pounds]).to eq player.weight_pounds
      expect(res[:team]).to be_nil
      expect(res[:team_id]).to eq team.public_id
    end
  end
end
