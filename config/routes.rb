Rails.application.routes.draw do
  devise_for :users


  resources :games do
    collection do
      get :twelve
      get :fifteen
    end
  end

  resources :users, only: [:show]
  get '/' => "games#index"


 # get '/users/:id' => "users#show"
end
