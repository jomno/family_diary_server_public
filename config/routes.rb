Rails.application.routes.draw do
  devise_for :users, path: "api", path_names: {
                       sign_in: "login",
                       sign_out: "logout",
                       registration: "signup",
                     },
                     controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "api/health_check#index"

  namespace :api, defaults: { format: :json } do
    get "health_check" => "health_check#index"

    resources :users, only: %i[] do
      collection do
        post "kakao"
      end
    end

    resources :current_user, only: %i[index] do
      collection do
        post "set_printer_email"
        post "print"
      end
    end

    resources :diaries, only: %i[index create show destroy update]
  end
end
