class IndexController < ApplicationController
  skip_before_action :login_required, only: [:login]
  skip_before_filter :verify_authenticity_token, only: [:login]

  def login
    if request.post?
      admin = Administrator.find_by(mobile: params[:login])      
      if admin.authenticate(params[:password])
        login_as(admin)

        if admin.admin_power        
          redirect_to users_path and return
        elsif admin.edit_power
          redirect_to partitions_path and return
        elsif admin.order_power
          redirect_to orders_path and return 
        end
        
      else
        redirect_to login_path and return
      end
    end

    render layout: false  

  end

end
