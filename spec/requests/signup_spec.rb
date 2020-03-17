require 'rails_helper'

# curl -i --header "Content-Type: application/json" -X POST -d '{"user":{"email":"admin@example.com","password":"12345678", "password_confirmation":"12345678"}}' http://localhost:3000/api/v1/signup
describe "POST /api/v1/signup", :type => :request do
  let(:url) { '/api/v1/signup' }
  let(:params) do
    {
      user: FactoryBot.attributes_for(:random_user)
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new user' do
      expect(response).to match_response_schema('user')
    end
  end

  context 'when user already exists' do
    let!(:user) {FactoryBot.create(:user, email: params[:user][:email], password: params[:user][:password])}
    before do
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(JSON.parse(response.body)["errors"][0]["title"]).to eq('Bad Request')
    end
  end
end