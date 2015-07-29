Rails.application.routes.draw do

  namespace :api do

    resource :user, only: [] do       
      post :login
      post :upload_avatar      
    end

    resources :user_shippings, only: [:index, :show, :create] do 
      collection do 
        get :lu
      end
    end    

    resources :goods, only: [:index, :show]

    resources :categories, only: [:index, :show]
    resources :partitions, only: [:index, :show]

    resources :cities, only: [:index, :show]
  end

  root 'index#login'

  match 'login'    => 'index#login', via: [:get, :post], as: :login
  match 'sign_out' => 'index#sign_out', via: [:get, :post], as: :sign_out  

  resources :users, only: [:index, :show]

  resources :categories, only: [:index, :create, :destroy]
  resources :partitions, only: [:index, :create, :destroy]
  resources :cities, only: [:index, :create, :destroy]
  resources :areas, only: [:index, :create, :destroy]
  resources :schools, only: [:index, :create, :destroy]
  
  resources :goods
  
  resources :orders, only: [:index, :show]

  resources :photos, only: [] do 
    collection do 
      post :handler
    end
  end

end