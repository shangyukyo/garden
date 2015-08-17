class Api::OrdersController < Api::ApplicationController

  def index

  end

  def show

  end

  def create
    begin
      authenticate!
      
      goods_info = MultiJson.load(params[:goods_info])
      @order     = @current_user.placed!(params[:user_shipping_id], goods_info)
            
    rescue => e
      raise e
      error e.inspect      
    end
  end

  def update
  end

end