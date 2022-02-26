Rails.application.routes.draw do
  resources :notes

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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
