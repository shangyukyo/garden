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
      @user_shipping.default = params[:default]
      @user_shipping.province  = params[:province]
      @user_shipping.city = params[:city]
      @user_shipping.region = params[:region]
      @user_shipping.address = params[:address]
      @user_shipping.zip_code = params[:zip_code]
      @user_shipping.name = params[:name]
      @user_shipping.mobile = params[:mobile]
      @user_shipping.save!
    rescue => e
      error e.inspect
    end
  end

end