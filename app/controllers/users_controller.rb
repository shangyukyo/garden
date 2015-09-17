class UsersController < ApplicationController

  def index
    pagination

    @users = User.all
    if params[:mobile].present?
      @users = @users.where(mobile: params[:mobile])      
    end

    @coupons = Coupon.default.effect_coupons.order('id desc')

    @total = @users.size
    @users = @users.order('id desc').offset(@o).limit(@per_page)    
  end

  def show
  end

  def shippings
    @user = User.find params[:id]
    @shippings = @user.user_shippings
  end

  def give_coupon
    begin
      coupon = Coupon.find(params[:coupon_id])

      users = params[:user] == 'all' ? User.all : User.where(id: params[:user])

      render json: {success: coupon.give_to(users)}
    rescue => e
      raise e
      render json: {success: false}
    end
  end

end
