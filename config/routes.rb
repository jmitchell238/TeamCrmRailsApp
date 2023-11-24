Rails.application.routes.draw do
  root 'public#index'
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# Defines the root path route ("/")
# root "articles#index"

  resources :tracks

  get '/members', to: 'members#index'
  get '/leaderboard', to: 'leaderboard#index'
  get '/tournaments', to: 'tournaments#index'
  get '/member_portal', to: 'member_portal#index'

end
