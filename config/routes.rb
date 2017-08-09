Rails.application.routes.draw do
  devise_for :users
  resources :games
  get '/' => "games#index"
  get '/users/:id' => "users#show"
end
