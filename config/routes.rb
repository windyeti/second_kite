Rails.application.routes.draw do
  default_url_options host: "localhost:3000"

  root to: 'ads#index'

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources :ads
  resources :accounts, only: [:show]
  resources :brands do
    resources :kite_names, shallow: true, only: [:index, :create, :show, :edit, :update, :destroy] do
      resources :kites, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
    end
    resources :board_names, shallow: true, only: [:create, :edit, :update, :show, :destroy] do
      resources :boards, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
    end
    resources :bar_names, shallow: true, only: [:create, :edit, :update, :show, :destroy] do
      resources :bars, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
    end
    resources :stuff_names, shallow: true, only: [:create, :edit, :update, :show, :destroy]
  end
  resources :attachments, only: [:destroy]
end
