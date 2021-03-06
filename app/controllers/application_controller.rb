class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  protect_from_forgery with: :exception

  helper_method :login?, :current_user

  before_action :login_required, :check_current_user_power


  def check_current_user_power
    if current_user.admin_power
      return
    elsif current_user.edit_power
      if not ["index", "partitions", "categories", "goods", "posters"].include? params[:controller]
        render text: "您权限不够！"
      else

        if params[:action] == "destroy"
          render text: "您权限不够"
        end


      end
    elsif current_user.order_power
      if not ["index", "orders"].include? params[:controller]
        render text: "您权限不够！"
      else

        if params[:action] == "destroy"
          render text: "您权限不够"
        end

      end      
    end
  end

  private

  class AccessDenied < Exception; end

  def login_required
    unless login?
      flash[:warning] = t('sessions.flashes.login_required')
      redirect_to login_path
    end
  end

  def email_confirmed_required
    if !current_user.confirmed?
      redirect_to new_users_confirmation_path(return_to: (request.fullpath if request.get?))
    end
  end

  def no_locked_required
    if login? and current_user.locked?
      raise AccessDenied
    end
  end

  def no_login_required
    if login?
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= login_from_session || login_from_cookies unless defined?(@current_user)
    @current_user
  end

  def login?
    !!current_user
  end

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    forget_me
  end

  def login_from_session
    if session[:user_id].present?
      begin
        Administrator.find session[:user_id]
      rescue
        session[:user_id] = nil
      end
    end
  end

  def login_from_cookies
    if cookies[:remember_token].present?
      if user = Administrator.find_by_remember_token(cookies[:remember_token])
        session[:user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def login_from_access_token
    @current_user ||= Administrator.find_by_access_token(params[:access_token]) if params[:access_token]
  end

  def store_location(path)
    session[:return_to] = path
  end

  def redirect_back_or_default(default)
    redirect_to(session.delete(:return_to) || default)
  end

  def forget_me
    cookies.delete(:remember_token)
  end

  def remember_me
    cookies[:remember_token] = {
      value: current_user.remember_token,
      expires: 2.weeks.from_now,
      httponly: true
    }
  end


  def per_page
    10
  end

  def pagination
    @page = (params[:page] || 1).to_i        
    @per_page = per_page    
    @o = (@page.to_i - 1) * @per_page    
  end  

end
