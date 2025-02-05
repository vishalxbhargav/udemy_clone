Rails.application.routes.draw do
  mount Motor::Admin => '/motor_admin'
  devise_for :users
  root "home#index"
  get "/search",to:"home#search"
  get "/search/page",to:"home#search_page",as: "search_page"
  get "/instructor",to:"instructor#index"
  get "/instructor/dashboard",to:"instructor#dashboard"
  get "/instructor/my_earning",to:"instructor#my_earning"

  resources :notifications,only:[:index]
  post "/notification/all_read",to:"notifications#all_read"

  namespace :forume do
    #forume routes
    resources :forumes,only:[:show] do
      resources :questions,shallow: true
    end
    resources :questions,only:[:show] do
      resources :answers,shallow: true
    end
    resources :answer,only:[:show] do
      resources :comments,shallow: true
    end
  end
  namespace :student do 
    get "/enrollment/course/:id", to:"enrollment#enrolled", as: "enrolled_in_course"
    get "/enrollment/:id", to:"enrollment#course"
   
    get "/my_learning", to:"enrollment#my_learning"
    get "/transaction_history",to: "enrollment#transaction_history"
    get "/dashboard",to: "enrollment#dashboard"
    get "/enrolled_course/:id",to: "enrollment#enrolled_course"
  end
  namespace :instructor do
    resources :courses do
      resources :chapters, shallow: true
    end
    get "/get_chapter/:id",to:"chapters#get_chapter"
    post "/mark_as_complete/:chapter_id",to:"progress#mark_as_complete"
  end
  namespace :payment do
    get "/checkout/new/:id",to:"checkout#new", as: "checkout"
    post "/checkout/create/:id",to:"checkout#create", as: "checkout_create"
    get "/checkout/success/:id",to:"checkout#success", as: "successfull"
    get "/checkout/cancel/:id",to:"checkout#cancel", as: "cancel"
    resources :webhook,only: [:create]
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
