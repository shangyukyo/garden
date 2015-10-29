class CouponsController < ApplicationController

  def index
    pagination
    @coupons = Coupon.default

    if params[:coupon_type] == "new_user"
      @coupons = Coupon.new_user
    elsif params[:coupon_type] == "consume_100"
      @coupons = Coupon.consume_100
    elsif params[:coupon_type] == "fill_coupon"
      @coupons = Coupon.fill_coupon
    end

    @total = @coupons.size
    @coupons = @coupons.order('id desc').offset(@o).limit(@per_page)
  end

  def create
    params.permit!
    coupon = Coupon.new
    coupon.name = params[:name]
    coupon.price = params[:price].to_f
    coupon.minimum = params[:minimum].to_f
    coupon.start_at = params[:start_at]
    coupon.expired_at = params[:expired_at]

    if params[:coupon_type] == 'fill_coupon'   
      coupon.coupon_type = Coupon.coupon_types[:fill_coupon]
    elsif params[:coupon_type] == 'new_user'
      coupon.coupon_type = Coupon.coupon_types[:new_user]
    elsif params[:coupon_type] == 'consume_100'
      coupon.coupon_type = Coupon.coupon_types[:consume_100]
    else
      coupon.coupon_type = Coupon.coupon_types[:default]
    end

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

    if coupon.save!
      redirect_to coupons_path(coupon_type: params[:coupon_type])
    else
      redirect_to :back, alert: coupon.errors.full_messages
    end
    
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    
    params.permit!      
    @coupon = Coupon.find(params[:id])
    @coupon.name = params[:name]
    @coupon.price = params[:price].to_f
    @coupon.minimum = params[:minimum].to_f
    @coupon.start_at = params[:start_at]
    @coupon.expired_at = params[:expired_at]

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

    if @coupon.save!
      redirect_to coupons_path(coupon_type: @coupon.coupon_type)
    else
      redirect_to :back, alert: @coupon.errors.full_messages
    end    
  end

  def destroy
    redirect_to :back if Coupon.find(params[:id]).destroy
  end
end
