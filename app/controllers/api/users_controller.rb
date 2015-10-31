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
      return
    end

    if not token.present? or token.body != params[:verfiy_code]
      error("验证码无效或者已过期!", status = 200)
      return
    else      
      @user = User.find_by(mobile: params[:mobile]) || User.new(mobile: params[:mobile])

      if !@user.invite_code.present? and @user.id.present?
        @user.generate_invite_code
      end

      if not @user.id.present?
        @user.generate_private_token
        @user.generate_invite_code
      end

      # @user.generate_private_token  
      @user.save
    end    
  end

  def use_invite_code
    authenticate!    
    
    if @current_user.invite_code == params[:code]
      error("不能使用自己的邀请码!", status = 200)
      return 
    end

    if @current_user.used_invite_code
      error("您已使用过邀请码!", status = 200)
      return 
    end

    if not User.find_by(invite_code: params[:code]).present?
      error("邀请码错误!", status = 200)      
      return
    end

    @current_user.use_invite_code params[:code]

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