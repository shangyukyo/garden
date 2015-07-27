class Api::CategoriesController < Api::ApplicationController

  def index
    categories = Category.all.order('id desc')
    
    res = categories.map do |category|
      {
        category: category, 
        goods: category.goods.published
      }
    end

    render_json res
  end

  def show
    begin
      category = Category.find params[:id]
      goods = category.goods.published

      render_json({category: category, goods: goods})
    rescue => e
      error e
    end
  end

end