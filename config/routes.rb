Rails.application.routes.draw do
  root 'main#index'

  resources :tracks
  resources :users

  resource :session
  resource :registration
  resource :password_reset
  resource :password
  resource :member_portal

  resources :rounds do
    resources :races
  end

  resources :races do
    resources :race_participations
  end

  get '/members', to: 'members#index'
  get '/leaderboard', to: 'leaderboard#index'

end
