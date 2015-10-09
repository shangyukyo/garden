class Api::UsersController < Api::ApplicationController

  def send_verfiy_code
    error "错误的参数!" if not params[:mobile].present?

    token = Token.generate_body params[:mobile]
    token.send_msg
    render_json send: 'ok'
  end

  def login
    token = Token.where(mobile: params[:mobile]).order("id desc").first    

    if not params[:mobile].present? or not params[:verfiy_code].present?
      error "错误的参数!", 200
    end

    puts token.inspect

    if not token.present? or token.body != params[:verfiy_code]
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