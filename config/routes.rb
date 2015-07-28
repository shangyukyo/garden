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
  end

  root 'index#login'

  match 'login'    => 'index#login', via: [:get, :post], as: :login
  match 'sign_out' => 'index#sign_out', via: [:get, :post], as: :sign_out  

  resources :users, only: [:index, :show]
  resources :categories, only: [:index, :create]
  
  resources :goods do 
    member do 
      get  :new_good_spec
      post :create_good_spec
    end
  end
  resources :orders, only: [:index, :show]

  resources :photos, only: [] do 
    collection do 
      post :handler
    end
  end

end
