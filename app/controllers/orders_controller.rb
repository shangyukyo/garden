class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :delivery]

  def index
    pagination    
    @orders = Order.all.order('id desc')

    if params[:order_no].present?
      @orders = @orders.where(order_no: params[:order_no])
    end

    if params[:warehouse_name].present?
      @orders = @orders.where("ext like ?", "%#{params[:warehouse_name]}%")
    end

    if params[:start_at].present?
      @orders = @orders.where("created_at > ?", params[:start_at])
    end

    if params[:end_at].present?
      @orders = @orders.where("created_at < ?", params[:end_at])
    end

    if params[:status].present?
      @orders  = @orders.try(params[:status].to_sym)
    end

    @total = @orders.size
    @orders = @orders.offset(@o).limit(@per_page)      
  end

  def show
    puts @order.inspect
    @order_goods = @order.order_goods
    puts @order_goods.inspect
  end

  def delivery
    @order.deliver!
    redirect_to :back
  end


  private

  def find_order
    @order = Order.find(params[:id])
  end
end
