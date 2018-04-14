Rails.application.routes.draw do

  resources :users do
    collection do
      post   :login
      delete :logout
      get    :feed
    end

    member do
      get :following, :followers, :feeder
    end
      
  end

  resources :blogs,         only: [:show, :create, :destroy] 

  resources :relationships, only: [:create, :destroy] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
