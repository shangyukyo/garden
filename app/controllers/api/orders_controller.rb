class Api::OrdersController < Api::ApplicationController

  def index
    authenticate!
    @orders = @current_user.orders.order('id desc')

    if params[:status] == "pending"
      @orders = @orders.pending
    elsif params[:status] == "paid"
      @orders = @orders.paid
    elsif params[:status] == "delivering"
      @orders = @orders.delivering
    elsif params[:status] == "finished"
      @orders = @orders.finished      
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
      @order     = @current_user.placed!(params[:user_shipping_id], goods_info, params[:coupon_id])
            
    rescue => e      
      error e.inspect      
    end
  end

  def update
  end

end