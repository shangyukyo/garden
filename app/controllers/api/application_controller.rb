class Api::ApplicationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  skip_before_action :verify_authenticity_token  
  skip_before_action :login_required
  
  layout false

  respond_to :json

  def current_user
    @current_user ||= User.find_by(private_token: params[:token])
  end

  def current_user=(new_user)
    @current_user = new_user
  end
  
  def authenticate!
    if params[:token].blank? || !current_user      
      raise '未登录或者登录实效'
    end
  end  

  def error(message, status = 200)      
    render json: { error: message }, status: 200 and return
  end

  def render_json(data)
    render json: {success: true, data: data}, status: 200
    return
  end
  
end
