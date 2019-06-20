# frozen_string_literal: true

describe UsersController, type: :controller do
  describe '#create' do
    let(:params) do
      { user: { email: 'foo@bar.com', password: 'foobar', password_confirmation: 'foobar' } }
    end
    let(:request) { post :create, params: params }

    it 'creates a user' do
      expect { request }.to change(User, :count).by(1)
      expect(response.status).to eq 200
      expect(User.find_by(email: 'foo@bar.com')).to_not be_nil
    end
  end
end
