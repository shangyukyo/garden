class CategoriesController < ApplicationController
  before_action :find_category, only: [:update, :switch_display, :destroy]

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

  def update
    params.permit!
    redirect_to :back if @category.update_attributes(name: params[:name], queue: params[:queue])
  end

  def switch_display
    @category.show? ? @category.hidden! : @category.show!
    redirect_to :back    
  end

  def destroy
    redirect_to :back if @category.destroy
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

end
