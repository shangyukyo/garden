class Api::GoodsController < Api::ApplicationController

  def index
    begin      
      category = Category.find params[:category_id]
      @goods = category.goods.published      
    rescue => e
      error e.inspect
    end
  end

  def show
    begin
      @good = Good.find params[:id]      
    rescue => e      
      error e.inspect
    end
  end

end