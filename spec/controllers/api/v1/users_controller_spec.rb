require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'User sign_in and sign_up' do
    let(:params) do
      { user: { email: 'my_email@gmail.com', password: '123456' } }
    end

    let(:wrong_credentials) do
      { user: { email: 'my_em@gmail.com', password: '12345' } }
    end

    before do
      post :create, params: params
    end

    context 'sign_up' do
      context 'success' do
        it 'returns token for the created user' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'fail' do
        context 'parameters empty' do
          before do
            post :create
          end

          it 'returns error message' do
            expect(response).to have_http_status(:bad_request)

            response_body = JSON.parse(response.body)
            expect(response_body).to eq('error' => 'Parameter user required')
          end
        end

        context 'missing password' do
          before do
            post :create, params: { user: { email: 'my_em@gmail.com' } }
          end

          it 'returns error message' do
            expect(response).to have_http_status(:bad_request)

            response_body = JSON.parse(response.body)
            expect(response_body).to eq('error' => { 'password' => ["can't be blank"] })
          end
        end

        context 'missing email' do
          before do
            post :create, params: { user: { password: '123456' } }
          end

          it 'returns error message' do
            expect(response).to have_http_status(:bad_request)

            response_body = JSON.parse(response.body)
            expect(response_body).to eq('error' => { 'email' => ["can't be blank", 'is invalid'] })
          end
        end

        context 'user already exists' do
          before do
            post :create, params: params
          end

          it 'returns message error' do
            expect(response).to have_http_status(:bad_request)

            response_body = JSON.parse(response.body)
            expect(response_body).to eq('error' => { 'email' => ['has already been taken'] })
          end
        end
      end
    end

    context 'sign_in' do
      context 'success' do
        before do
          post :login, params: params
        end

        it 'returns token for the logged in user' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'fail' do
        before do
          post :login, params: wrong_credentials
        end

        it 'wrong credentials' do
          expect(response).to have_http_status(:bad_request)

          response_body = JSON.parse(response.body)
          expect(response_body).to eq('error' => 'Invalid credentials')
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
