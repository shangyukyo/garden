Rails.application.routes.draw do

  namespace :api do

    resource :user, only: [] do 
      post :login
    end

  end
end
