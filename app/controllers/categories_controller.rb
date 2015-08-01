class CategoriesController < ApplicationController

  def index
    pagination
    @categories = Category.normal
    @total = @categories.size
    @categories = @categories.order('queue desc').offset(@o).limit(@per_page)    
  end

  def create
    params.permit!
    redirect_to :back if Category.create(name: params[:name], category_type: Category.category_types[:normal], queue: params[:queue].to_i)
  end

  def destroy
    redirect_to :back if Category.find(params[:id]).destroy
  end

end
