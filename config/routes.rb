Rails.application.routes.draw do
  default_url_options host: "localhost:3000"

  root to: 'ads#index'

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources :ads
  resources :kites, only: [:new, :create, :show]
  resources :accounts, only: [:show]
  resources :brands do
    resources :kite_names, shallow: true, only: [:index, :create, :show, :edit, :update, :destroy]
  end

end
