Rails.application.routes.draw do
  default_url_options host: "localhost:3000"

  root to: 'ads#index'

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources :ads

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
