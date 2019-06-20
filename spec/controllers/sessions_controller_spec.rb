# frozen_string_literal: true

describe SessionsController, type: :controller do
  describe '#create' do
    let!(:user) { create(:user, email: 'foo@bar.com', password: 'password') }
    let(:request) { post :create, params: params }

    before { request }

    context "when email isn't recognized" do
      let(:params) { { email: 'd@p.com' } }

      it 'returns 404' do
        expect(response.status).to eq 404
      end
    end

    context 'when password is incorrect' do
      let(:params) { { email: 'foo@bar.com', password: 'p' } }

      it 'returns 404' do
        expect(response.status).to eq 404
      end
    end

    context 'when email and password are correct' do
      let(:params) { { email: 'foo@bar.com', password: 'password' } }

      it 'returns 200' do
        expect(response.status).to eq 200
      end
    end
  end
end
