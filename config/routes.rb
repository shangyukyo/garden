Rails.application.routes.draw do

  namespace :api do

    resource :user, only: [] do       
      post :login
      post :upload_avatar      
    end

    resources :user_shippings, only: [:index, :show, :create] do 
      collection do 
        get :lu
        post :delete
      end      

      member do
        post :update        
      end
    end    

    resources :goods, only: [:index, :show] do 
      member do 
        get :description
      end

      collection do 
        get :search
        get :hot_keywords
      end
    end

    resources :categories, only: [:index, :show]
    resources :partitions, only: [:index, :show]

    resources :cities, only: [:index, :show] do 
      collection do 
        get :search
      end
    end

    resources :orders

    resources :coupons, only: [:index]

    resources :posters, only: [:index]
  end

  # root 'index#login'  

  match 'login'    => 'index#login', via: [:get, :post], as: :login
  match 'sign_out' => 'index#sign_out', via: [:get, :post], as: :sign_out  

  resources :users, only: [:index, :show] do 
    member do 
      get :shippings      
    end

    collection do 
      post :give_coupon
    end
  end

  resources :categories do
    member do 
      get :switch_display
    end
  end

  resources :partitions do 
    member do 
      get :switch_display
    end
  end

  resources :cities, only: [:index, :create, :destroy]
  resources :areas, only: [:index, :create, :destroy]
  resources :schools, only: [:index, :create, :destroy]
  
  resources :goods
  
  resources :orders, only: [:index, :show] do 
    member do
      post :delivery
    end
  end

  resources :photos, only: [] do 
    collection do 
      post :handler
      post :handle_poster
    end
  end

  resources :coupons

  resources :posters do 
    collection do
      post :good_info
    end
  end

end
