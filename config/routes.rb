Rails.application.routes.draw do
  devise_for :users


  resources :games do
    collection do
      get :checker
    end
  end

  resources :users, only: [:show]
  get '/' => "games#index"


 # get '/users/:id' => "users#show"
end
