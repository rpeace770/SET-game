Rails.application.routes.draw do
  devise_for :users
  resources :games
  resources :users, only: [:show]
  get '/' => "games#index"


 # get '/users/:id' => "users#show"
end
