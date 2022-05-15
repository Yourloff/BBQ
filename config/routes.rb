Rails.application.routes.draw do
  root to: "events#index"

  resources :events
  resources :users, only: [:show, :edit, :update]
end
