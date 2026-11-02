Rails.application.routes.draw do
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  resources :users,
            only: [:index, :new, :create, :show, :edit, :update],
            path_names: { new: "sign_up" }

  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check

  get "home/about", to: "homes#about", as: :about

  root to: "homes#top"
end