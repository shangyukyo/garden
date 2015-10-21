Rails.application.routes.draw do

  namespace :api do

    resource :user, only: [] do       
      post :login
      post :upload_avatar

      collection do 
        post :send_verfiy_code
        post :use_invite_code
      end
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

    resources :orders do 
      collection do 
        post :purchase
        post :wechat_purchase
      end
    end

    resources :coupons, only: [:index]

    resources :posters, only: [:index]

    resource :notify, only: [] do
      collection do 
        post :alipay
        post :wechat
      end
    end
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
      post :finish
    end
  end

  resources :photos, only: [] do 
    collection do 
      post :handler
      post :handle_poster
    end
  end

  resources :coupons

  resources :administrators

  resources :posters do 
    collection do
      post :good_info
    end
  end


  resources :regions
  resources :warehouses

end
