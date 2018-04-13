Rails.application.routes.draw do

  get '/signup', to: 'users#new'
  resources :users do
    collection do
      post   :login
      delete :logout
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
