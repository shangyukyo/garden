class Api::OrdersController < Api::ApplicationController

  def index
    authenticate!
    @orders = @current_user.orders.order('id desc')

    if params[:status] == "pending"
      @orders = @orders.pending.limit(8)
    elsif params[:status] == "paid"
      @orders = @orders.paid.limit(8)
    elsif params[:status] == "delivering"
      @orders = @orders.delivering.limit(8)
    elsif params[:status] == "finished"
      @orders = @orders.finished.limit(8) 
    end
  end

  def show
    authenticate!
    @order = @current_user.orders.find(params[:id])    
  end

  def create
    begin
      authenticate!
      
      goods_info = MultiJson.load(params[:goods_info])
      @order     = @current_user.placed!(params[:user_shipping_id], goods_info, params[:coupon_id], params[:warehouse_id])
            
    rescue => e      
      error e.message      
    end
  end

  def clone
    begin
      authenticate!

      target_order = @current_user.orders.find_by order_no: params[:order_no]

      @order = target_order.clone params[:warehouse_id]
    rescue => e
      error e.message
    end
  end

  def purchase
    begin    
      ActiveRecord::Base.transaction do 
        order                   = Order.find_by order_no: params[:order_no]

        if Order.statuses[order.status] >=  1
          error "订单不能重复支付!"
          return 
        end

        if params[:coupon_id].present?
          order.use_coupon params[:coupon_id]
        end

        @payment                 = Payment.new
        @payment.user            = order.user
        @payment.subject         = "订单支付"        
        @payment.original_amount = order.total_price
        @payment.gateway         = :alipay
        @payment.save!
        order.payments << @payment        
      end
    rescue => e      
      error e.message
    end
  end


  def wechat_purchase
    begin    
      ActiveRecord::Base.transaction do 
        order                   = Order.find_by order_no: params[:order_no]


        if Order.statuses[order.status] >=  1
          error "订单不能重复支付!"
          return 
        end

        if params[:coupon_id].present?
          order.use_coupon params[:coupon_id]
        end

        @payment                 = Payment.new
        @payment.user            = order.user
        @payment.subject         = "订单支付"        
        @payment.original_amount = order.total_price
        @payment.gateway         = :wechat
        @payment.save!
        order.payments << @payment        
      end
    rescue => e      
      error e.message
    end    
  end

end