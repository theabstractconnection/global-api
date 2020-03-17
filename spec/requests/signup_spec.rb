require 'rails_helper'
require 'spec_helper'
require 'swagger_helper'

describe 'Auth' do
  # curl -i --header "Content-Type: application/json" -X POST -d '{"user":{"email":"admin@example.com","password":"12345678", "password_confirmation":"12345678"}}' http://localhost:3000/api/v1/signup
  path '/api/v1/signup' do
    post 'singup a user' do
      tags 'authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        required: [ 'user' ],
        properties: {
          user: { 
            type: :object,
            required: [ 'email', 'password', 'password_confirmation' ],
            properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
          },
        },
      }

      let!(:persistedUser) { create(:user, email: "user@example.com", password: "password") }
      let!(:unpersistedUser) { attributes_for(:user, email: "user2@example.com", password: "password") }

      response '200', 'User signed in' do
        let(:user) do 
          {
            user: {
              email: unpersistedUser[:email],
              password: unpersistedUser[:password],
              password_confirmation: unpersistedUser[:password]
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
          expect(response.status).to eq 200
        end
    
        it 'returns a new user' do
          expect(response).to match_response_schema('user')
        end
      end
      
      response '400', 'Bad Request' do
        let(:user) do 
          {
            user: {
              email: persistedUser.email,
              password: persistedUser.password,
              password_confirmation: persistedUser.password
            }
          }
        end

        before do |example|
          submit_request(example.metadata)
        end
        
        it 'returns bad request status' do
          expect(response.status).to eq 400
        end
    
        it 'returns validation errors' do
          expect(JSON.parse(response.body)["errors"][0]["title"]).to eq('Bad Request')
        end
      end

    end
  end
end