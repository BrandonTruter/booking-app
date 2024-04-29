Rails.application.routes.draw do
  resources :entities, only: [:index] do
    get 'login', on: :member
  end
  resources :diaries, only: [:index]
  resources :bookings
  get 'search', to: 'bookings#search', as: :collection


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "entities#index"
end
