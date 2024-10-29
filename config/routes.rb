Rails.application.routes.draw do
  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    registration: "signup"
  }, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  namespace :api do
    namespace :v1 do
      get "current_user", to: "current_user#index"
      resources :todos do
        resources :comments
        member do
          post :complete
        end
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
