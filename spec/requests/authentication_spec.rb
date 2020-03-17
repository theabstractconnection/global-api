require 'rails_helper'
require 'spec_helper'
require 'swagger_helper'

describe 'Auth' do
  # curl -i --header "Content-Type: application/json" -X POST -d '{"user":{"email":"admin@example.com","password":"12345678"}}' http://localhost:3000/api/v1/login
  path '/api/v1/login' do
    post 'login a user' do
      tags 'authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        required: [ 'user' ],
        properties: {
          user: { 
            type: :object,
            required: [ 'email', 'password' ],
            properties: {
              email: { type: :string},
              password: { type: :string}
            },
          },
        },
      }
      
      let!(:persistedUser) { create(:user, email: "user@example.com", password: "password") }

      response '200', 'User logged in' do
        let(:user) do 
          {
            user: {
              email: persistedUser.email,
              password: persistedUser.password
            }
          }
        end

        examples({'application/json' => 
          {
            id: 1,
            email:"user@example.com",
            created_at: "2020-03-17T10:33:20.638Z",
            updated_at: "2020-03-17T10:33:20.638Z"
          }
        })
        
        before do |example|
          submit_request(example.metadata)
        end

        it 'returns 200' do
          expect(response).to have_http_status(200)
        end
        
        it 'returns a valid response' do |example|
          assert_response_matches_metadata(example.metadata)
        end

        it 'returns JTW token in authorization header' do
          expect(response.headers['Authorization']).to be_present
        end
    
        it 'returns valid JWT token' do
          decoded_token = decoded_jwt_token_from_response(response)
          expect(decoded_token.first['sub']).to be_present
        end
      end


      response '401', 'Error: Unauthorized' do
        let(:user) { { } }
        run_test!
      end

    end
  end

  # curl -i --header "Content-Type: application/json" -X DELETE http://localhost:3000/api/v1/logout
  path '/api/v1/logout' do
    delete 'logout a user' do
      tags 'authentication'
      consumes 'application/json'

      response '204', 'no content' do
        run_test!
      end
    end
  end
end


def decoded_jwt_token_from_response response
  return decoded = JWT.decode(response.headers['Authorization'].split('Bearer ')[1], ENV['DEVISE_JWT_SECRET_KEY'])
end