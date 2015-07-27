class Api::ApplicationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  skip_before_action :verify_authenticity_token  
  skip_before_action :login_required

  respond_to :json

  def current_user
    @current_user ||= User.find_by(private_token: params[:token])
  end

  def current_user=(new_user)
    @current_user = new_user
  end
  
  def authenticate!
    if params[:token].blank? || !current_user
      error('未登录或登录已失效', 401)
    end
  end  

  private

  def error(message, status = 200)
    render json: { error: message }, status: status and return
  end

  def render_json(data)
    render json: {success: true, data: data}, status: 200 and return
  end
  
end
