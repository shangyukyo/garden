Rails.application.routes.draw do

  namespace :api do

    resource :user, only: [] do 
      post :login
      post :upload_avatar
    end
  end

  root 'index#login'

  match 'login'    => 'index#login', via: [:get, :post], as: :login
  match 'sign_out' => 'index#sign_out', via: [:get, :post], as: :sign_out

  resources :users, only: [:index, :show]
  resources :categories, only: [:index, :create]
  resources :goods
  resources :orders, only: [:index, :show]


end
