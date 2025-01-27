Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "/search",to:"home#search"
  get "/instructor",to:"instructor#index"
  get "/instructor/dashboard",to:"instructor#dashboard"

  namespace :student do
    get "/enrollment/:id", to:"enrollment#course"
    post "/enrollment/:id", to:"enrollment#enrolled"
    get "/my_learning", to:"enrollment#my_learning"
    get "/transaction_history",to: "enrollment#transaction_history"
    get "/dashboard",to: "enrollment#dashboard"
    get "/enrolled_course/:id",to: "enrollment#enrolled_course"
  end
  namespace :instructor do
    resources :courses do
      resources :chapters, shallow: true
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
