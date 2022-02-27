require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  describe 'tasks' do
    before do
      FactoryBot.create :user, email: 'my_email@gmail.com', password: '123456'
    end

    let(:token) { JwtAuthService.new('my_email@gmail.com', '123456').authenticate }
    let(:user) { OpenStruct.new(JwtAuthService.decode_token(token)[0]['user']) }
    let(:params) do
      { "task": { "title": "First task", "status": "completed" } }
    end

    context 'manages tasks' do
      context 'success' do
        context 'create task' do
          before do
            request.headers['Authorization'] = "Bearer #{token}"
            post :create, params: params
          end

          it 'returns task created' do
            expect(response).to have_http_status(:success)

            response_body = JSON.parse(response.body)
            expect(response_body).to eq({"task"=>{"id"=>1, "title"=>"First task", "status"=>"completed"}})
          end
        end

        context 'completed tasks' do
          before do
            request.headers['Authorization'] = "Bearer #{token}"
            post :create, params: params
            post :create, params: params
            get :completed
          end

          it 'returns only completed' do
            expect(response).to have_http_status(:success)

            response_body = JSON.parse(response.body)
            completed_tasks = JSON.parse(Task.completed.to_json)
            expect(response_body).to eq({"tasks"=> completed_tasks})
          end
        end

        context 'not completed tasks' do
          let(:params_uncompleted) do
            { "task": { "title": "First task", "status": "uncompleted" } }
          end

          before do
            request.headers['Authorization'] = "Bearer #{token}"
            post :create, params: params
            post :create, params: params_uncompleted
            post :create, params: params_uncompleted
            get :uncompleted
          end

          it 'returns only not completed' do
            expect(response).to have_http_status(:success)

            response_body = JSON.parse(response.body)
            uncompleted_tasks = JSON.parse(Task.uncompleted.to_json)
            expect(response_body).to eq({"tasks"=> uncompleted_tasks})
          end
        end
      end

      context 'fail' do
        before do
          post :create, params: params
        end

        it 'authentication required' do
          expect(response).to have_http_status(:forbidden)
        end

        context 'authenticated' do
          context 'parameters missing' do
            context 'without title' do
              let(:without_title) do
                { "task": { "status": "completed" } }
              end

              before do
                request.headers['Authorization'] = "Bearer #{token}"
                post :create, params: without_title
              end

              it "doesn't create task" do
                expect(response).to have_http_status(:forbidden)
              end
            end

            context 'empty parameters' do
              before do
                request.headers['Authorization'] = "Bearer #{token}"
                post :create
              end

              it 'returns error message' do
                expect(response).to have_http_status(:bad_request)

                response_body = JSON.parse(response.body)
                expect(response_body).to eq({ 'error'=> 'Parameter title is missing' })
              end
            end
          end
        end
      end
    end
  end
end
