Rails.application.routes.draw do
  # match '/*path', to: AuthorizationController.action(:authenticate!), via: :all
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest


  post "/identity/new", to: "users#create"
  post "identity/session/new", to: "sessions#login"
  get "identity/session/check", to: "sessions#check"
  delete "identity/session/logout", to: "sessions#logout"

  get "bookings/history", to: "resource/bookings#bookings"

  # get "/me", to: "users#me"


  # Defines the root path route ("/")
  # root "posts#index"
end
