class Api::UsersController < Api::ApplicationController

  def send_verfiy_code 
  end

  def login
    token = Token.where(mobile: params[:mobile], body: params[:verfiy_code])

    if not params[:mobile].present?
      error "错误的参数!", 200
    end

    if false #not token.present?
      error("验证码无效或者已过期!", status = 200)
    else      
      @user = User.find_by(mobile: params[:mobile]) || User.new(mobile: params[:mobile])
      @user.generate_private_token  
      @user.save
    end    
  end

  def upload_avatar
    begin
      authenticate!    
      @current_user.avatar = params[:avatar]
      @current_user.save!     
    rescue => e
      error e.inspect, 502
    end
  end

end