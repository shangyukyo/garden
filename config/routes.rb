Rails.application.routes.draw do

  namespace :api do

    resource :user, only: [] do 
      post :login
      post :upload_avatar
    end

  end
end
