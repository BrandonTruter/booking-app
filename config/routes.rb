Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :bookings
      resources :diaries, only: [:index]
      resources :sessions, only: [:create]
      resources :patients, only: [:index]
      resources :debtors, only: [:index]
    end
  end

  resources :diaries, only: [:index]
  resources :bookings do
    get 'search', on: :collection
  end
  resources :entities, only: [:index] do
    resources :diaries, only: [:index]
  end

  root "entities#index"
end
