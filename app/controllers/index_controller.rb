class IndexController < ApplicationController
  skip_before_action :login_required, only: [:login]
  skip_before_filter :verify_authenticity_token, only: [:login]

  def login
    if request.post?
      admin = Administrator.find_by(mobile: params[:login])      
      # if user.present?
      #   redirect_to login_path and return unless params[:password] == '123456'        
      #   login_as(user)
      #   redirect_to users_path and return 
      # end
      if admin.authenticate(params[:password])
        login_as(admin)
        redirect_to users_path and return
      else
        redirect_to login_path and return
      end
    end

    render layout: false  

  end

end
