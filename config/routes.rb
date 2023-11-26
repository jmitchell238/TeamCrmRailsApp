Rails.application.routes.draw do
  root 'main#index'

  resources :tracks
  resources :users

  resource :session, only: [:new, :create, :destroy]
  resource :registration, only: [:new, :create]
  resource :password_reset, only: [:new, :create, :edit, :update]
  resource :password, only: [:edit, :update]
  resource :member_portal, only: [:show]

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
    resources :leaderboards, only: [:new, :show, :create]
  end

  resources :leaderboards

  # Additional custom routes
  get '/members', to: 'members#index'
  get '/leaderboard', to: 'leaderboard#index'
end
