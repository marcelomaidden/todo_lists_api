Rails.application.routes.draw do
  resources :users

  resources :tasks do
    collection do
      get :completed
      get :uncompleted
    end

    member do
      put :complete
      put :uncomplete
    end
  end

  post 'login', to: "users#login"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
