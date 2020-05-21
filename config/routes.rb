require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  default_url_options host: "localhost:3000"

  root to: 'ads#index'

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources :ads

  resources :accounts, only: [:show, :edit, :update]

  resources :kites, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :brands do
    resources :kite_names, shallow: true, only: [:index, :create, :show, :edit, :update, :destroy] do
      resources :subscriptions, only: [:create, :destroy], shallow: true, defaults: { subscriptionable: 'kite_names' }
    end
    resources :board_names, shallow: true, only: [:create, :edit, :update, :show, :destroy] do
      resources :boards, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
      resources :subscriptions, only: [:create, :destroy], shallow: true, defaults: { subscriptionable: 'board_names' }
    end
    resources :bar_names, shallow: true, only: [:create, :edit, :update, :show, :destroy] do
      resources :bars, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
      resources :subscriptions, only: [:create, :destroy], shallow: true, defaults: { subscriptionable: 'bar_names' }
    end
    resources :stuff_names, shallow: true, only: [:create, :edit, :update, :show, :destroy] do
      resources :stuffs, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
      resources :subscriptions, only: [:create, :destroy], shallow: true, defaults: { subscriptionable: 'stuff_names' }
    end
  end

  resources :singly_sales do
    collection do
      get 'kites', to: 'singly_sales#kites'
      get 'boards', to: 'singly_sales#boards'
      get 'bars', to: 'singly_sales#bars'
      get 'stuffs', to: 'singly_sales#stuffs'
    end
  end

  resources :attachments, only: [:destroy]
  resources :searches, only: [:index]
end
