class Api::UserShippingsController < Api::ApplicationController

  def lu
    authenticate!
    @provinces = Lu::Province.all
  end

  def index
    authenticate!
    @user_shippings = @current_user.user_shippings
  end

  def show
    authenticate!
    @user_shipping = @current_user.user_shippings.find_by(id: params[:id])  
  end

  def create
    begin
      authenticate!
      @user_shipping = @current_user.user_shippings.build
      @user_shipping.default = params[:defaults]
      @user_shipping.area  = params[:area]
      @user_shipping.school = params[:school]      
      @user_shipping.address = params[:address]
      @user_shipping.name = params[:name]
      @user_shipping.mobile = params[:mobile]
      @user_shipping.save!
    rescue => e
      error e.inspect
    end
  end

  def update
    begin
      authenticate!
      @user_shipping = @current_user.user_shippings.find_by params[:id]
      @user_shipping.default = params[:defaults]
      @user_shipping.area  = params[:area]
      @user_shipping.school = params[:school]      
      @user_shipping.address = params[:address]
      @user_shipping.name = params[:name]
      @user_shipping.mobile = params[:mobile]
      @user_shipping.save!
    rescue => e
      error e.inspect
    end    
  end

end