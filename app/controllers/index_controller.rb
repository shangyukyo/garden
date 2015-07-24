class IndexController < ApplicationController
  skip_before_action :login_required, only: [:login]
  skip_before_filter :verify_authenticity_token, only: [:login]

  def login
    if request.post?
      user = User.find_by(mobile: params[:login])      
      if user.present?
        redirect_to login_path and return unless params[:password] == '123456'        
        login_as(user)
        redirect_to users_path and return 
      end
    end
    render layout: false  

  end

end
