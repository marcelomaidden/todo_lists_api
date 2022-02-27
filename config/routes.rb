Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes, only: %i[show update destroy]

      resources :users, only: %i[show create]

      resources :tasks do
        collection do
          get :completed
          get :uncompleted
        end

        member do
          put :complete
          put :uncomplete
          patch :complete
          patch :uncomplete
          get :notes, to: "notes#index"
          post :notes, to: "notes#create"
        end
      end

      post 'login', to: "users#login"
    end
  end
end
