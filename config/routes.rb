Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords"
  }
devise_scope :user do
    post "users/google_oauth", to: "users/omniauth_callbacks#google_oauth"
  end
  namespace :api do
    namespace :v1 do
      resources :places
       resources :users
resources :quiz_histories, only: [ :create, :index, :destroy ]
put "users/update", to: "users#update"
  get "/me", to: "users#me"

      # ✅ Google Login Route (React will hit this)
      post "quiz/generate", to: "quiz#generate"
    end
  end
    post "google_login", to: "users/omniauth#google_token"
post "/users/google_oauth", to: "users/omniauth_callbacks#google_oauth"
end
