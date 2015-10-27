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
      error e.message
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

      if @user_shipping.save!
        if @user_shipping.default?
          @current_user.user_shippings.where.not(id: @user_shipping.id).update_all default: false
        end
      end

    rescue => e
      error e.message
    end    
  end

  def delete
    begin
      authenticate!
      @user_shipping = @current_user.user_shippings.find_by id: params[:id]
      @user_shipping.destroy!
    rescue => e
      error e.message
    end
  end

end