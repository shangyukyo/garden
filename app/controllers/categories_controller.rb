class CategoriesController < ApplicationController

  def index
    pagination

    @categories = Category.all
    @total = @categories.size
    @categories = @categories.order('id desc').offset(@o).limit(@per_page)    
  end

  def create
    params.permit!
    redirect_to :back if Category.create(name: params[:name])
  end

end
