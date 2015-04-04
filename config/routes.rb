Rails.application.routes.draw do
  resources :sheets do
    collection do
      get ":sheet_key", to: "sheets#sheet_key", as: :sheet_key
      get ":sheet_key/:worksheet_id", to:  "sheets#worksheet", as: :worksheet
    end
  end

  root to: 'sheets#index'
  resources :sessions, only: [:new, :create, :destroy]

  get "/auth/:provider/callback" => 'sessions#create'
  get "logout" => 'sessions#destroy'
end
