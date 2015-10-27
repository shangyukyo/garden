class Api::GoodsController < Api::ApplicationController

  def index
    begin      
      category = Category.find params[:category_id]
      @goods = category.goods.published

      if params[:by_sales].present?
        @goods = @goods.order("sales #{params[:by_sales]}")
      end

      if params[:by_price].present?
        @goods = @goods.order("price #{params[:by_price]}")
      end

    rescue => e
      error e.message
    end
  end

  def show
    begin
      @good = Good.find params[:id]      
    rescue => e      
      error e.message
    end
  end

  def description
    render html: Good.find(params[:id]).description.html_safe
  end

  def search
    @goods = Good.where("name like ?", "%#{params[:name]}%")
  end

  def hot_keywords
    render json: Good.last(10).map(&:name)
  end

end