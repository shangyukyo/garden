class Api::CategoriesController < Api::ApplicationController

  def index
    @categories = Category.all.order('id desc')
    
    res = @categories.map do |category|
      {
        category: category, 
        goods: category.goods.published
      }
    end
    
  end

  def show
    begin
      @category = Category.find params[:id]      
    rescue => e
      error e.inspect
    end
  end

end