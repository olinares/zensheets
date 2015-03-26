Rails.application.routes.draw do
  resources :sheets
  root to: 'sheets#index'
  resources :sessions, only: [:new, :create, :destroy]

  get "/auth/:provider/callback" => 'sessions#create'
  get "logout" => 'sessions#destroy'
end
