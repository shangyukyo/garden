class Api::CategoriesController < Api::ApplicationController

  def index
    @categories = Category.normal.show.order('queue desc')  
  end

  def show
    begin
      @category = Category.find params[:id]      
    rescue => e
      error e.inspect
    end
  end

end