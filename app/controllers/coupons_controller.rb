class CouponsController < ApplicationController

  def index
    pagination
    @coupons = Coupon.all
    @total = @coupons.size
    @coupons = @coupons.order('id desc').offset(@o).limit(@per_page)
  end

  def create
    params.permit!
    
  end

  def destroy
    redirect_to :back if Coupon.find(params[:id]).destroy
  end
end
