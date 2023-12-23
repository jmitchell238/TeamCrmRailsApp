# frozen_string_literal: true

Rails.application.routes.draw do
  root 'main#index'

  resources :tracks
  resources :users

  resource :session, only: %i[new create destroy]
  resource :registration, only: %i[new create]
  resource :password_reset, only: %i[new create edit update]
  resource :password, only: %i[edit update]
  resource :member_portal, only: [:show]
  resource :admin_portal, only: [:show]

  # If user_registrations need nested resources or member/collection routes, they can be added here
  resources :user_registrations

  resources :tournaments do
    # Custom member/collection routes for tournaments if needed
    # For example:
    member do
      get :participants
    end
    collection do
      get :ongoing
    end
  end

  resources :rounds do
    resources :races do
      # Member route for setting race positions or calculating scores
      member do
        post :set_positions
      end
      # Nested resource for race_participations under races
      resources :race_participations
    end
  end

  # If races are not always nested under rounds (they can be accessed individually), they should be a top-level resource as well
  resources :races do
    resources :race_participations
  end

  # If race_participations need to be accessible outside the context of a specific race, add them here as well
  resources :race_participations

  resources :tracks do
    resources :leaderboards, only: %i[new show create] do
      resources :lap_times, only: %i[new create destroy]
    end
  end

  resources :leaderboards

  # Additional custom routes
  get '/members', to: 'members#index'
  get '/leaderboard', to: 'leaderboard#index'
  get '/tracks/fetch_names', to: 'tracks#fetch_names'
  get 'tracks_by_type', to: 'leaderboards#tracks_by_type'
  get 'leaderboards_by_track_type', to: 'leaderboards#leaderboards_by_track_type'
  get 'leaderboards_by_track', to: 'leaderboards#leaderboards_by_track'
  get 'track_leaderboards_by_track_condition', to: 'leaderboards#track_leaderboards_by_track_condition'
end
