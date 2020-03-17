require 'spec_helper'

# curl -i --header "Content-Type: application/json" -X POST -d '{"user":{"email":"admin@example.com","password":"12345678"}}' http://localhost:3000/api/v1/login
describe 'POST /api/v1/login', type: :request do
  let(:user) { FactoryBot.create(:random_user) }
  let(:url) { '/api/v1/login' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      decoded_token = decoded_jwt_token_from_response(response)
      expect(decoded_token.first['sub']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url }
    
    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

# curl -i --header "Content-Type: application/json" -X DELETE http://localhost:3000/api/v1/logout
describe 'DELETE /api/v1/logout', type: :request do
  let(:url) { '/api/v1/logout' }

  it 'returns 204, no content' do
    delete url
    expect(response).to have_http_status(204)
  end
end

def decoded_jwt_token_from_response response
  return decoded = JWT.decode(response.headers['Authorization'].split('Bearer ')[1], ENV['DEVISE_JWT_SECRET_KEY'])
end