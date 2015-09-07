class CouponsController < ApplicationController

  def index
    pagination
    @coupons = Coupon.all
    @total = @coupons.size
    @coupons = @coupons.order('id desc').offset(@o).limit(@per_page)
  end

  def create
    params.permit!
    coupon = Coupon.new
    coupon.name = params[:name]
    coupon.price = params[:price].to_f
    coupon.start_at = params[:start_at]
    coupon.expired_at = params[:expired_at]
    coupon.coupon_type = Coupon.coupon_types[:default]

    if not params[:start_at].present?
      redirect_to :back, alert: '有效期 开始时间不能为空' and return
    end

    if not params[:expired_at].present?
      redirect_to :back, alert: '有效期 结束时间不能为空' and return
    end    

    if not params[:price].to_f > 0
      redirect_to :back, alert: '价值必须大于0' and return
    end

    if not params[:name].present?
      redirect_to :back, alert: '名称不能为空' and return
    end

    if coupon.save
      redirect_to coupons_path
    else
      redirect_to :back, alert: coupon.errors.full_messages
    end
    
  end

  def destroy
    redirect_to :back if Coupon.find(params[:id]).destroy
  end
end
